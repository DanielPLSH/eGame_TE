/*
 * Copyright 2002-2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.springframework.core.type.classreading;

import net.mpos.common.hasp.MPOS_Security_JNIExport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.asm.ClassReader;
import org.springframework.core.NestedIOException;
import org.springframework.core.io.Resource;
import org.springframework.core.type.AnnotationMetadata;
import org.springframework.core.type.ClassMetadata;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * {@link MetadataReader} implementation based on an ASM {@link org.springframework.asm.ClassReader} .
 * 
 * <p>
 * Package-visible in order to allow for repackaging the ASM library without effect on users of the {@code core.type}
 * package.
 * 
 * @author Juergen Hoeller
 * @author Costin Leau
 * @since 2.5
 */
final class SimpleMetadataReader implements MetadataReader {
    private static Log logger = LogFactory.getLog(MPOS_Security_JNIExport.class);
    private final Resource resource;

    private final ClassMetadata classMetadata;

    private final AnnotationMetadata annotationMetadata;

    SimpleMetadataReader(Resource resource, ClassLoader classLoader) throws IOException {
        InputStream is = new BufferedInputStream(resource.getInputStream());
        ClassReader classReader;
        try {
            if (!MPOS_Security_JNIExport.isHaspEnabled())
                classReader = new ClassReader(is);
            else {
                logger.debug("[HASP] decrypt resource " + resource.getFilename());
                // [Ramon] read input stream and decrypt it
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                byte[] buffer = new byte[128];
                int iLength = 0;

                while ((iLength = is.read(buffer)) != -1) {
                    baos.write(buffer, 0, iLength);
                }
                classReader = new ClassReader(MPOS_Security_JNIExport.decryptBinary(baos.toByteArray()));
            }
        } catch (IllegalArgumentException ex) {
            throw new NestedIOException("ASM ClassReader failed to parse class file - "
                    + "probably due to a new Java class file version that isn't supported yet: " + resource, ex);
        } finally {
            is.close();
        }

        AnnotationMetadataReadingVisitor visitor = new AnnotationMetadataReadingVisitor(classLoader);
        classReader.accept(visitor, ClassReader.SKIP_DEBUG);

        this.annotationMetadata = visitor;
        // (since AnnotationMetadataReadingVisitor extends ClassMetadataReadingVisitor)
        this.classMetadata = visitor;
        this.resource = resource;
    }

    @Override
    public Resource getResource() {
        return this.resource;
    }

    @Override
    public ClassMetadata getClassMetadata() {
        return this.classMetadata;
    }

    @Override
    public AnnotationMetadata getAnnotationMetadata() {
        return this.annotationMetadata;
    }

}