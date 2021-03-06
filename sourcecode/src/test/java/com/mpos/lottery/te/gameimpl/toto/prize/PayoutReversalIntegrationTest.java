package com.mpos.lottery.te.gameimpl.toto.prize;

import static org.junit.Assert.assertEquals;

import com.mpos.lottery.te.common.dao.BaseJpaDao;
import com.mpos.lottery.te.config.exception.SystemException;
import com.mpos.lottery.te.gameimpl.toto.domain.ToToTicket;
import com.mpos.lottery.te.gamespec.game.Game;
import com.mpos.lottery.te.gamespec.prize.Payout;
import com.mpos.lottery.te.gamespec.prize.dao.PayoutDao;
import com.mpos.lottery.te.gamespec.prize.dao.PayoutDetailDao;
import com.mpos.lottery.te.gamespec.prize.web.PrizeDto;
import com.mpos.lottery.te.gamespec.sale.BaseTicket;
import com.mpos.lottery.te.gamespec.sale.dao.BaseTicketDao;
import com.mpos.lottery.te.merchant.domain.Operator;
import com.mpos.lottery.te.port.Context;
import com.mpos.lottery.te.test.integration.BaseServletIntegrationTest;
import com.mpos.lottery.te.trans.dao.TransactionDao;
import com.mpos.lottery.te.trans.domain.Transaction;
import com.mpos.lottery.te.trans.domain.TransactionType;

import org.junit.Test;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

public class PayoutReversalIntegrationTest extends BaseServletIntegrationTest {
    @Resource(name = "transactionDao")
    private TransactionDao transactionDao;
    @Resource(name = "baseTicketDao")
    private BaseTicketDao baseTicketDao;
    @Resource(name = "payoutDao")
    private PayoutDao payoutDao;
    @Resource(name = "payoutDetailDao")
    private PayoutDetailDao payoutDetailDao;
    @Resource(name = "baseJpaDao")
    private BaseJpaDao baseJpaDao;

    @Test
    public void testPayout_Reversal_OK() throws Exception {
        printMethod();
        ToToTicket ticket = new ToToTicket();
        ticket.setRawSerialNo("T-123456");
        ticket.setValidationCode("111111");
        ticket.setPIN("PIN-111");

        BigDecimal oldCreditOperator = this.getBaseJpaDao().findById(Operator.class, "OPERATOR-111")
                .getPayoutCreditLevel();

        // 1. make payout
        Context reqCtx = this.getDefaultContext(TransactionType.PAYOUT.getRequestType(), ticket);
        reqCtx.setGameTypeId(Game.TYPE_TOTO + "");
        Context respCtx = doPost(this.mockRequest(reqCtx));
        PrizeDto prize = (PrizeDto) respCtx.getModel();

        // force to flush to underlying database to avoid FALSE POSITIVE
        this.entityManager.flush();
        this.entityManager.clear();

        // 2. reverse payout
        Transaction trans = new Transaction();
        trans.setDeviceId(reqCtx.getTerminalId());
        trans.setTraceMessageId(reqCtx.getTraceMessageId());
        Context reversalCtx = this.getDefaultContext(TransactionType.CANCEL_BY_TRANSACTION.getRequestType(), trans);
        Context reversalRespCtx = doPost(this.mockRequest(reversalCtx));

        // force to flush to underlying database to avoid FALSE POSITIVE
        this.entityManager.flush();
        this.entityManager.clear();

        // assert response
        assertEquals(200, respCtx.getResponseCode());

        // assert the credit level
        BigDecimal newCreditOperator = this.getBaseJpaDao().findById(Operator.class, "OPERATOR-111")
                .getPayoutCreditLevel();
        assertEquals(oldCreditOperator.doubleValue(), newCreditOperator.doubleValue(), 0);

        // assert Transaction
        Transaction expectedTrans = new Transaction();
        expectedTrans.setId(reversalRespCtx.getTransactionID());
        expectedTrans.setTotalAmount(prize.getActualAmount());
        expectedTrans.setGameId("GAME-TOTO-1");
        expectedTrans.setTotalAmount(prize.getActualAmount());
        expectedTrans.setTicketSerialNo(ticket.getSerialNo());
        expectedTrans.setOperatorId(reversalRespCtx.getOperatorId());
        expectedTrans.setMerchantId(111);
        expectedTrans.setDeviceId(reversalRespCtx.getTerminalId());
        expectedTrans.setTraceMessageId(reversalRespCtx.getTraceMessageId());
        expectedTrans.setType(reversalCtx.getTransType());
        expectedTrans.setResponseCode(SystemException.CODE_OK);
        Transaction dbTrans = this.getTransactionDao().findById(Transaction.class, reversalRespCtx.getTransactionID());
        this.assertTransaction(expectedTrans, dbTrans);

        // check ticket status
        // List<LottoTicket> dbTickets =
        List<ToToTicket> dbTickets = this.getBaseTicketDao().findBySerialNo(ToToTicket.class, ticket.getSerialNo(),
                false);
        assertEquals(BaseTicket.STATUS_ACCEPTED, dbTickets.get(0).getStatus());

        // check payout records
        // List<Payout> payouts =
        this.getPayoutDao().getByTicketSerialNo(ticket.getSerialNo());
        List<Payout> payouts = this.getPayoutDao().getByTicketSerialNo(ticket.getSerialNo());
        assertEquals(Payout.STATUS_REVERSED, payouts.get(0).getStatus());
    }

    public TransactionDao getTransactionDao() {
        return transactionDao;
    }

    public void setTransactionDao(TransactionDao transactionDao) {
        this.transactionDao = transactionDao;
    }

    public BaseTicketDao getBaseTicketDao() {
        return baseTicketDao;
    }

    public void setBaseTicketDao(BaseTicketDao baseTicketDao) {
        this.baseTicketDao = baseTicketDao;
    }

    public PayoutDao getPayoutDao() {
        return payoutDao;
    }

    public void setPayoutDao(PayoutDao payoutDao) {
        this.payoutDao = payoutDao;
    }

    public PayoutDetailDao getPayoutDetailDao() {
        return payoutDetailDao;
    }

    public void setPayoutDetailDao(PayoutDetailDao payoutDetailDao) {
        this.payoutDetailDao = payoutDetailDao;
    }

    public BaseJpaDao getBaseJpaDao() {
        return baseJpaDao;
    }

    public void setBaseJpaDao(BaseJpaDao baseJpaDao) {
        this.baseJpaDao = baseJpaDao;
    }

}
