delete from GAME_TYPE where GAME_TYPE_ID=1;
delete from GAME where GAME_ID in ('GAME-111', 'GAME-113');
delete from GAME_MERCHANT where ID like 'GM-LOTTO-%';
delete from LOTTO_FUN_TYPE;
delete from LOTTO_OPERATION_PARAMETERS;
delete from PRIZE_PARAMETERS;
delete from OBJECT_PRIZE_PARAMETERS;
delete from GAME_RESULTS;
delete from GAME_INSTANCE;
delete from TE_TRANSACTION where exists(select * from TE_TRANSACTION t,GAME g where t.game_id=g.game_id and g.game_type_id=1);
delete from MERCHANT_GAME_PROPERTIES where MRID like '%-LOTTO-%';  
delete from TE_LOTTO_ENTRY;
delete from TE_TICKET;
delete from PAYOUT where ID like 'P-LOTTO-%';
delete from WINNING;
delete from WINNING_STATISTICS;
delete from WINNING_DAILY_CASH;
delete from WINNING_OBJECT;
delete from BD_PRIZE_GROUP_ITEM where id like 'LOTTO-%';    

-- GAME_TYPE
insert into GAME_TYPE(GAME_TYPE_ID,TYPE_NAME) values(1, 'LOTT');

-- GAME
insert into GAME(
    GAME_ID,GAME_TYPE_ID,FUNDAMENTAL_TYPE_ID,OPERATION_PARAMETERS_ID,WINNER_TAX_POLICY_ID,
    TAX_CALCULATION_METHOD,GAME_NAME,STATUS,TAX_CALCULATION_BASED
) values(
    'GAME-111', 1, 'FTI-111','OP-111','TP-1',2,'GLC-LOTTO',1,1
);
insert into GAME(
    GAME_ID,GAME_TYPE_ID,FUNDAMENTAL_TYPE_ID,OPERATION_PARAMETERS_ID,GAME_NAME,TAX_CALCULATION_METHOD,
    STATUS,TAX_CALCULATION_BASED
) values(
    'GAME-113', 1, 'FTI-111','OP-111','4Digit',1,1,1
);

-- LOTTO_FUN_TYPE
insert into LOTTO_FUN_TYPE(LFT_ID,KKK,NNN,XXX,YYY,EXTRA_NO,POWER_BALL,POWER_PLAY,
    BOX_BETS,FREE_PLAY,DISCOUNTING_FOR_SEASON,SECOND_CHANCE_PROMOTION,FREE_BALLS
) values(
    'FTI-111',6,36,0,0,0,0,0,0,0,0,0,0
);

insert into LOTTO_OPERATION_PARAMETERS(
    LOTTO_OP_PARAMETERS_ID,BASE_AMOUNT,MIN_MULTI_DRAW,MAX_MULTI_DRAW,ALLOW_OFFLINE,
    OFFLINE_UPLOAD_DEADLINE,ALLOW_CANCELLATION,PAYOUT_MODEL,AMOUNT_FLEXIBLE,GAME_PLAY_FORMAT,
    BANKER, MULTIPLE, MULTIPLE_COUNT
) values(
    'OP-111',100.0,1,10,1,10,1,1,1,1,1,1,100
);

-- GAME_MERCHANT 
insert into GAME_MERCHANT(
    ID, MERCHANT_ID, GAME_ID, COMMISSION_RATE_SALES, COMMISSION_RATE_PAYOUT
) values(
    'GM-LOTTO-111', 111, 'GAME-111',0.1,0.1
);
insert into GAME_MERCHANT(
    ID, MERCHANT_ID, GAME_ID, COMMISSION_RATE_SALES, COMMISSION_RATE_PAYOUT
) values(
    'GM-LOTTO-113', 111, 'GAME-113',0.3,0.3
);
insert into GAME_MERCHANT(
    ID, MERCHANT_ID, GAME_ID, COMMISSION_RATE_SALES, COMMISSION_RATE_PAYOUT
) values(
    'GM-LOTTO-114', 222, 'GAME-111',0.1,0.1
);
insert into GAME_MERCHANT(
    ID, MERCHANT_ID, GAME_ID, COMMISSION_RATE_SALES, COMMISSION_RATE_PAYOUT
) values(
    'GM-LOTTO-116', 222, 'GAME-113',0.3,0.3
);
insert into GAME_MERCHANT(
    ID, MERCHANT_ID, GAME_ID, COMMISSION_RATE_SALES, COMMISSION_RATE_PAYOUT
) values(
    'GM-LOTTO-117', 112, 'GAME-113',0.3,0.3
);

-- ============================================================== --
-- MERCHANT_GAME_PROPERTIES                                              --
-- ============================================================== -- 
insert into MERCHANT_GAME_PROPERTIES(
    MRID, MERCHANT_ID, GAME_ID,OPERATOR_ID, COMMISSION_RATE, COMMISSION_RATE_PAYOUT
) values(
    'MG-LOTTO-111', 111, 'GAME-111','OPERATOR-111',0.0,0.0
);
insert into MERCHANT_GAME_PROPERTIES(
    MRID, MERCHANT_ID, GAME_ID,OPERATOR_ID, COMMISSION_RATE, COMMISSION_RATE_PAYOUT
) values(
    'MG-LOTTO-113', 111, 'GAME-113','OPERATOR-111',0.0,0.0
);
insert into MERCHANT_GAME_PROPERTIES(
    MRID, MERCHANT_ID, GAME_ID,OPERATOR_ID, COMMISSION_RATE, COMMISSION_RATE_PAYOUT
) values(
    'MG-LOTTO-114', 222, 'GAME-111','OPERATOR-112',0.0,0.0
);
insert into MERCHANT_GAME_PROPERTIES(
    MRID, MERCHANT_ID, GAME_ID,OPERATOR_ID, COMMISSION_RATE, COMMISSION_RATE_PAYOUT
) values(
    'MG-LOTTO-116', 222, 'GAME-113','OPERATOR-112',0.0,0.0
);

-- GAME INSTANCE
insert into GAME_INSTANCE(
    GAME_INSTANCE_ID,PRIZE_LOGIC_ID,GAME_ID,GAME_INSTANCE_NAME,DRAW_NO,
    DRAW_DATE,START_SELLING_TIME,STOP_SELLING_TIME,IS_SNOWBALL,STATUS,MAX_CLAIM_PERIOD,
    VERSION,GAME_FREEZING_TIME,CONTORL_METHOD,SALES_AMOUNT_PERCENT,LOSS_AMOUNT
) values(
    'GII-111','OPL-1','GAME-111','test-game-draw','20090401',
    sysdate-3,sysdate-5, sysdate-3,0,7,3650,1,sysdate-3+30/(24*60),2, 0.4, 15000
);
insert into GAME_INSTANCE(GAME_INSTANCE_ID,PRIZE_LOGIC_ID,GAME_ID,GAME_INSTANCE_NAME,DRAW_NO,
    DRAW_DATE,START_SELLING_TIME,STOP_SELLING_TIME,IS_SNOWBALL,STATUS,MAX_CLAIM_PERIOD,VERSION,GAME_FREEZING_TIME
    ,CONTORL_METHOD,SALES_AMOUNT_PERCENT,LOSS_AMOUNT
) values(
    'GII-112','OPL-1','GAME-111','test-game-draw','20090403',
    sysdate-1,sysdate-3,sysdate-1,0,7,3650,1,sysdate-1+30/(24*60),2, 0.4, 15000
);
insert into GAME_INSTANCE(GAME_INSTANCE_ID,PRIZE_LOGIC_ID,GAME_ID,GAME_INSTANCE_NAME,DRAW_NO,
    DRAW_DATE,START_SELLING_TIME,STOP_SELLING_TIME,IS_SNOWBALL,STATUS,MAX_CLAIM_PERIOD,VERSION,
    GAME_FREEZING_TIME,ANNOUNCED_JACKPOT,CONTORL_METHOD,SALES_AMOUNT_PERCENT,LOSS_AMOUNT,BD_CHANNEL_SETTING_ID
) values(
    'GII-113','OPL-1','GAME-111','test-game-draw','20090408',
    sysdate+1,sysdate-1,sysdate+1,0,2,3650,0,sysdate+1+30/(24*60),1000000.0,2, 0.4, 15000,'Channel-1'
);
insert into GAME_INSTANCE(GAME_INSTANCE_ID,PRIZE_LOGIC_ID,GAME_ID,GAME_INSTANCE_NAME,DRAW_NO,
    DRAW_DATE,START_SELLING_TIME,STOP_SELLING_TIME,IS_SNOWBALL,STATUS,MAX_CLAIM_PERIOD,VERSION,GAME_FREEZING_TIME
    ,CONTORL_METHOD,SALES_AMOUNT_PERCENT,LOSS_AMOUNT
) values(
    'GII-114','OPL-1','GAME-111','test-game-draw','20090416',
    sysdate+3,sysdate+1,sysdate+3,0,1,3650,0,sysdate+3+30/(24*60),2, 0.4, 15000
);
insert into GAME_INSTANCE(GAME_INSTANCE_ID,PRIZE_LOGIC_ID,GAME_ID,GAME_INSTANCE_NAME,DRAW_NO,
    DRAW_DATE,START_SELLING_TIME,STOP_SELLING_TIME,IS_SNOWBALL,STATUS,MAX_CLAIM_PERIOD,VERSION,GAME_FREEZING_TIME
    ,CONTORL_METHOD,SALES_AMOUNT_PERCENT,LOSS_AMOUNT
) values(
    'GII-115','OPL-1','GAME-111','test-game-draw','20090508',
    sysdate+5,sysdate+3,sysdate+5,0,1,3650,0,sysdate+5+30/(24*60),2, 0.4, 15000
);    
insert into GAME_INSTANCE(GAME_INSTANCE_ID,PRIZE_LOGIC_ID,GAME_ID,GAME_INSTANCE_NAME,DRAW_NO,
    DRAW_DATE,START_SELLING_TIME,STOP_SELLING_TIME,IS_SNOWBALL,STATUS,MAX_CLAIM_PERIOD,VERSION,GAME_FREEZING_TIME
    ,CONTORL_METHOD,SALES_AMOUNT_PERCENT,LOSS_AMOUNT
) values(
    'GII-116','OPL-1','GAME-113','test-game-draw-113','20090508',
    sysdate-1,sysdate-3,sysdate-1,0,7,3650,1,sysdate-1+30/(24*60),2, 0.4, 15000
); 

update GAME_INSTANCE set IS_SUSPEND_PAYOUT=0,OBJECT_PRIZE_LOGIC_ID='OPL-1';    
update GAME_INSTANCE set OBJECT_PRIZE_LOGIC_ID='OPL-1' where GAME_INSTANCE_ID='GII-111'; 
update GAME_INSTANCE set IS_SUSPEND_SALE=0;
update GAME_INSTANCE set IS_SUSPEND_MANUAL_CANCEL=0;

-- GAME RESULT
insert into GAME_RESULTS(GAME_RESULT_ID,GAME_INSTANCE_ID,RESULT_NO,SPECIA_NO,VERSION)
    values('GRI-111','GII-111','1,2,3,4,5,6','11',1);   
insert into GAME_RESULTS(GAME_RESULT_ID,GAME_INSTANCE_ID,RESULT_NO,SPECIA_NO,VERSION)
    values('GRI-112','GII-111','7,2,3,4,5,6','12',1);   
insert into GAME_RESULTS(GAME_RESULT_ID,GAME_INSTANCE_ID,RESULT_NO,SPECIA_NO,VERSION)
    values('GRI-113','GII-116','6,2,3,4,5,16','16',1); 

-- TRANSACTION    
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TICKET_SERIAL_NO,TRACE_MESSAGE_ID,BATCH_NO,GAME_ID
) values(
    'TRANS-110','OPERATOR-111','GPE-111',111,111,to_date('2009-07-20 16:37:41','YYYY-MM-DD HH24:MI:SS'),
    200,sysdate,200,'200415681002','TMI-091','20092009','GAME-111'
);  
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TICKET_SERIAL_NO,TRACE_MESSAGE_ID,BATCH_NO,GAME_ID
) values(
    'TRANS-111','OPERATOR-111','GPE-111',111,111,sysdate,200,sysdate,200,
    'S-123456','TMI-111','200901','GAME-111'
);
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TICKET_SERIAL_NO,TRACE_MESSAGE_ID,BATCH_NO,GAME_ID
) values(
    'TRANS-112','OPERATOR-111','GPE-111',111,111,sysdate,302,sysdate,200,
    'S-888888','TMI-112','200901','GAME-111'
);
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TICKET_SERIAL_NO,TRACE_MESSAGE_ID,BATCH_NO,GAME_ID
) values(
    'TRANS-911','OPERATOR-111','GPE-111',111,111,sysdate,302,sysdate,200,
    'S-999999','TMI-911','200901','GAME-111'
);
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TICKET_SERIAL_NO,TRACE_MESSAGE_ID,BATCH_NO,GAME_ID
) values(
    'TRANS-912','OPERATOR-111','GPE-111',111,111,sysdate,200,sysdate,200,
    'S-999999','TMI-911','200901','GAME-111'
);
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TICKET_SERIAL_NO,TRACE_MESSAGE_ID,BATCH_NO,GAME_ID
) values(
    'TRANS-113','OPERATOR-111','GPE-111',111,111,sysdate,201,sysdate,200,
    'S-654321','TMI-113','200901','GAME-111'
);
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TICKET_SERIAL_NO,TRACE_MESSAGE_ID,BATCH_NO,GAME_ID
) values(
    'TRANS-114','OPERATOR-111','GPE-111',111,111,sysdate,200,sysdate,200,
    'S-654321','TMI-114','200901','GAME-111'
);
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TRACE_MESSAGE_ID,BATCH_NO,GAME_ID
) values(
    'TRANS-115','OPERATOR-111','GPE-111',111,111,sysdate,203,sysdate,200,
    'TMI-114','200901','GAME-111'
);
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TRACE_MESSAGE_ID,TICKET_SERIAL_NO,BATCH_NO,GAME_ID
) values(
    'TRANS-116','OPERATOR-111','GPE-111',111,111,sysdate,203,sysdate,200,
    'TMI-114','S-888888','200901','GAME-111'
);
insert into TE_TRANSACTION(
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TRACE_MESSAGE_ID,TICKET_SERIAL_NO,BATCH_NO,GAME_ID,TOTAL_AMOUNT
) values(
    'TRANS-117','OPERATOR-111','GPE-111',111,111,sysdate,201,sysdate,333,
    'TMI-115','S-111111','200901','GAME-111',800.1
);
-- cancel by transaction
insert into TE_TRANSACTION( 
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TRACE_MESSAGE_ID,TICKET_SERIAL_NO,BATCH_NO,GAME_ID
) values(
    'TRANS-122','OPERATOR-111','GPE-111',111,111,sysdate,206,sysdate,200,
    'TMI-122','S-2009123101','200901','GAME-111'
);
insert into TE_TRANSACTION( 
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TRACE_MESSAGE_ID,TICKET_SERIAL_NO,BATCH_NO,GAME_ID
) values(
    'TRANS-123','OPERATOR-111','GPE-111',111,111,sysdate,206,sysdate,333,
    'TMI-123','S-2009123102','200901','GAME-111'
);
insert into TE_TRANSACTION( 
    ID,OPERATOR_ID,GPE_ID,DEV_ID,MERCHANT_ID,CREATE_TIME,TYPE,TRANS_TIMESTAMP,RESPONSE_CODE,
    TRACE_MESSAGE_ID,TICKET_SERIAL_NO,BATCH_NO,GAME_ID
) values(
    'TRANS-124','OPERATOR-111','GPE-111',111,111,sysdate,200,sysdate,200,
    'TMI-124','S-2009123101','200901','GAME-111'
);

update TE_TRANSACTION set version=0;    

-- TICKET
insert into TE_TICKET(  
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-110','GII-111','TRANS-110',1,sysdate,sysdate,'S-123456-a',2500.1,0,1,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,1,200,'111111',0
);
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW,BARCODE
) values(
    'TICKET-111','GII-111','TRANS-111',1,sysdate,sysdate,'S-123456',2500.1,1,1,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,3,200,'111111',1,'01cK/u9hwZY2Rogq4k24Oeg4G3HSlAl9EbjLdf+UJJlt/ITKo3ngns+4pjWl52Uuv1'
); 
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW,BARCODE
) values(
    'TICKET-112','GII-112','TRANS-111',1,sysdate,sysdate,'S-123456',2500.1,0,1,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,0,200,'111111',0,'01cK/u9hwZY2Rogq4k24Oeg4G3HSlAl9EbjLdf+UJJlt/ITKo3ngns+4pjWl52Uuv1'
); 
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW,BARCODE
) values(
    'TICKET-113','GII-113','TRANS-111',1,sysdate,sysdate,'S-123456',2500.1,0,1,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,0,200,'111111',0,'01cK/u9hwZY2Rogq4k24Oeg4G3HSlAl9EbjLdf+UJJlt/ITKo3ngns+4pjWl52Uuv1'
); 
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-114','GII-113','TRANS-114',1,sysdate,sysdate,'S-654321',2000.1,0,2,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,1,201,'111111',0
);
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-115','GII-111','TRANS-115',1,sysdate,sysdate,'S-888888',100.1,0,5,
    'f5e09f731f7dffc2a603a7b9b977b2ca',1,1,1,200,'111111',0
);
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-116','GII-113','TRANS-117',1,sysdate,sysdate,'S-111111',800.1,0,4,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,1,201,'111111',0
); 
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-117','GII-113','TRANS-122',1,sysdate,sysdate,'S-2009123101',600,0,2,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,1,206,'111111',0
); 
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-118','GII-113','TRANS-123',1,sysdate,sysdate,'S-2009123102',700,0,4,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,1,206,'111111',0
); 
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-119','GII-111','TRANS-912',1,sysdate-1,sysdate,'S-999999',100,0,5,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,2,200,'111111',0
); 
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-119b','GII-112','TRANS-912',1,sysdate-1,sysdate,'S-999999',100,0,0,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,0,200,'111111',0
);
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-119c','GII-112','TRANS-912',1,sysdate,sysdate,'S-999999-NEWPRINT',100,0,1,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,1,302,'111111',0
);
insert into TE_TICKET(
    ID,GAME_INSTANCE_ID,TRANSACTION_ID,VERSION,CREATE_TIME,UPDATE_TIME,
    SERIAL_NO,TOTAL_AMOUNT,IS_WINNING,STATUS,PIN,IS_OFFLINE,IS_COUNT_IN_POOL,MUTLI_DRAW,
    TRANS_TYPE,VALIDATION_CODE,IS_WINING_lUCKY_DRAW
) values(
    'TICKET-120','GII-111','TRANS-112',1,sysdate,sysdate,'S-123456-a',100,0,1,
    'f5e09f731f7dffc2a603a7b9b977b2ca',0,1,1,200,'111111',0
); 
update TE_TICKET set IS_BLOCK_PAYOUT=0;
update te_ticket set dev_id=111;
update te_ticket set merchant_id=111;
update te_ticket set operator_id='OPERATOR-111';
update te_ticket set ticket_type=1;
update te_ticket set ticket_type=2 where ID='TICKET-120';
update TE_TICKET set ticket_from=1;
update TE_TICKET set TOTAL_BETS=1;    
update TE_TICKET set LD_WINING_TOTAL_BETS=1;    
update TE_TICKET set EXTEND_TEXT='90091b1caee72b14c5269c9214e66dab' where SERIAL_NO='S-123456';  

-- LOTTO ENTRY
insert into TE_LOTTO_ENTRY(
    ID,VERSION,CREATE_TIME,ENTRY_NO,TICKET_SERIALNO,BET_OPTION,SELECTED_NUMBER,IS_QUIDPICK,TOTAL_BETS,ENTRY_AMOUNT,BOOST_AMOUNT
) values(
    'LENTRY-1',0,sysdate,1,'S-123456',1,'1,2,3,4,5,6',0,1,100,50
);
insert into TE_LOTTO_ENTRY(
    ID,VERSION,CREATE_TIME,ENTRY_NO,TICKET_SERIALNO,BET_OPTION,SELECTED_NUMBER,IS_QUIDPICK,TOTAL_BETS,ENTRY_AMOUNT
) values(
    'LENTRY-2',0,sysdate,2,'S-123456',2,'1,2,3,4,5,6,7',0,6,100
);
insert into TE_LOTTO_ENTRY(
    ID,VERSION,CREATE_TIME,ENTRY_NO,TICKET_SERIALNO,BET_OPTION,SELECTED_NUMBER,IS_QUIDPICK,TOTAL_BETS,ENTRY_AMOUNT
) values(
    'LENTRY-3',0,sysdate,3,'S-123456',3,'1,2,3,4,5',0,44,100
);
insert into TE_LOTTO_ENTRY(
    ID,VERSION,CREATE_TIME,ENTRY_NO,TICKET_SERIALNO,BET_OPTION,SELECTED_NUMBER,IS_QUIDPICK,TOTAL_BETS,ENTRY_AMOUNT
) values(
    'LENTRY-4',0,sysdate,1,'S-888888',1,'1,2,3,4,5,6',0,1,100
);
insert into TE_LOTTO_ENTRY(
    ID,VERSION,CREATE_TIME,ENTRY_NO,TICKET_SERIALNO,BET_OPTION,SELECTED_NUMBER,IS_QUIDPICK,TOTAL_BETS,ENTRY_AMOUNT
) values(
    'LENTRY-5',0,sysdate,2,'S-888888',2,'1,2,3,4,5,6,7',0,6,100
);
insert into TE_LOTTO_ENTRY(
    ID,VERSION,CREATE_TIME,ENTRY_NO,TICKET_SERIALNO,BET_OPTION,SELECTED_NUMBER,IS_QUIDPICK,TOTAL_BETS,ENTRY_AMOUNT
) values(
    'LENTRY-6',0,sysdate,3,'S-888888',3,'1,2,3,4,5',0,44,100
);
update TE_LOTTO_ENTRY set MULTIPLE_COUNT=1;

-- ---------------------------------------------------------------------------------------------------
-- Winning Statistics of Ticket 'S-123456'
-- ---------------------------------------------------------------------------------------------------
-- <Prize actualAmount="4887973" isVerifyPIN="1" luckyAmount="0" mode="1" prizeAmount="7232000" taxAmount="1054040">
--     <Ticket serialNo="S-123456" totalAmount="7500.3"/>
--     <PrizeItem>
--         <GameDraw gameId="GAME-111" number="20090401"/>
--         <Winning actualAmount="4000001" level="1" numberOfPrize="1" prizeAmount="5000000" taxAmount="1000000"/>
--         <Winning actualAmount="8001" level="5" numberOfPrize="2" prizeAmount="10000" taxAmount="2000"/>
--         <Winning actualAmount="2991" level="7" numberOfPrize="4" prizeAmount="3000" taxAmount="10"/>
--     </PrizeItem>
--     <PrizeItem>
--         <GameDraw gameId="GAME-111" number="20090403"/>
--         <Winning actualAmount="350001" level="2" numberOfPrize="2" prizeAmount="1000000" taxAmount="5000"/>
--         <Winning actualAmount="40001" level="4" numberOfPrize="4" prizeAmount="50000" taxAmount="10000"/>
--         <Winning actualAmount="0" level="8" numberOfPrize="3" prizeAmount="0" taxAmount="0"/>
--     </PrizeItem>
-- </Prize>

-- WINNING
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-1',1,sysdate,sysdate,'S-123456','GII-111','LENTRY-1',1,1,1
);
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-2',1,sysdate,sysdate,'S-123456','GII-111','LENTRY-2',5,2,1
);
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-3',1,sysdate,sysdate,'S-123456','GII-111','LENTRY-2',7,4,1
);
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-4',1,sysdate,sysdate,'S-123456','GII-112','LENTRY-3',2,2,1
);
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-5',1,sysdate,sysdate,'S-123456','GII-112','LENTRY-3',4,1,1
);
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-6',1,sysdate,sysdate,'S-123456','GII-112','LENTRY-2',4,3,1
);
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-7',1,sysdate,sysdate,'S-888888','GII-111','LENTRY-5',1,1,1
);
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-8',1,sysdate,sysdate,'S-888888','GII-111','LENTRY-6',3,3,1
);
-- 7th prize level
insert into WINNING(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,TICKET_SERIALNO,GAME_INSTANCE_ID,ENTRY_ID,
    PRIZE_LEVEL,PRIZE_NUMBER,IS_VALID
) values(
    'W-9',1,sysdate,sysdate,'S-123456','GII-112','LENTRY-2',8,3,1
);

-- WINNING STATISTICS
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-1',1,sysdate,sysdate,1,1,5000000.0,'GII-111',1000000.0,4000001.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-2',1,sysdate,sysdate,2,2,1000000.0,'GII-112',5000.0,350001.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-3',1,sysdate,sysdate,3,10,500000.0,'GII-111',4000.0,460001.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-4',1,sysdate,sysdate,4,5,50000.0,'GII-112',10000.0,40001.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-5',1,sysdate,sysdate,5,22,10000.0,'GII-111',2000.0,8001.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-6',1,sysdate,sysdate,6,112,7000.0,'GII-111',10.0,6991.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-7',1,sysdate,sysdate,7,433,3000.0,'GII-111',10.0,2991.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-8',1,sysdate,sysdate,7,122,3000.0,'GII-112',10.0,2991.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-9',1,sysdate,sysdate,8,122,0.0,'GII-112',0.0,0.0
);
insert into WINNING_STATISTICS(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,PRIZE_LEVEL,PRIZE_NUMBER,PRIZE_AMOUNT,
    GAME_INSTANCE_ID,TAX_AMOUNT,ACTUAL_PAYOUT
) values(
    'WS-10',1,sysdate,sysdate,8,122,0.0,'GII-116',0.0,0.0
);

-- ============================================================== --
-- WINNING_OBJECT                                                 --
-- ============================================================== --
insert into WINNING_OBJECT(
    id, version, create_time, ticket_serialno,game_instance_id,prize_level, prize_number,is_valid
) values(
    'WO-1',1,sysdate,'S-123456','GII-111',1,1,1
);    
insert into WINNING_OBJECT(
    id, version, create_time, ticket_serialno,game_instance_id,prize_level, prize_number,is_valid
) values(
    'WO-2',1,sysdate,'S-123456','GII-111',3,1,1
); 
insert into WINNING_OBJECT(
    id, version, create_time, ticket_serialno,game_instance_id,prize_level, prize_number,is_valid
) values(
    'WO-3',1,sysdate,'S-123456','GII-116',1,1,1
);    

-- PAYOUT
insert into PAYOUT(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,GAME_INSTANCE_ID,TRANSACTION_ID,TICKET_SERIALNO,
    TOTAL_AMOUNT,TYPE,IS_VALID,STATUS,IS_BY_MANUAL,GAME_ID
) values(
    'P-LOTTO-1',1,sysdate,sysdate,'GII-111','TRANS-112','S-888888',10000.0,1,1,1,0,'GAME-111'
);
insert into PAYOUT(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,GAME_INSTANCE_ID,TRANSACTION_ID,TICKET_SERIALNO,
    TOTAL_AMOUNT,TYPE,IS_VALID,STATUS,IS_BY_MANUAL,GAME_ID
) values(
    'P-LOTTO-2',1,sysdate,sysdate,'GII-111','TRANS-112','S-888888',50.0,2,1,1,0,'GAME-111'
);
insert into PAYOUT(
    ID,VERSION,CREATE_TIME,UPDATE_TIME,GAME_INSTANCE_ID,TRANSACTION_ID,TICKET_SERIALNO,
    TOTAL_AMOUNT,TYPE,IS_VALID,STATUS,IS_BY_MANUAL,GAME_ID
) values(
    'P-LOTTO-11',1,sysdate,sysdate,null,'TRANS-911','S-999999',100.0,1,1,1,0,'GAME-111'
);
update payout set dev_id=111, merchant_id=111,operator_id='OPERATOR-111'; 
update payout set total_amount_b4_tax = total_amount + 10;
update payout set object_num=1;

-- PRIZE_PARAMETER
insert into PRIZE_PARAMETERS(PARAMETER_ID,PRIZE_LOGIC_ID,PARAMETER_NAME,IS_PRIZE_OBJECT) values('P-1','OPL-1','1',0);  
insert into PRIZE_PARAMETERS(PARAMETER_ID,PRIZE_LOGIC_ID,PARAMETER_NAME,IS_PRIZE_OBJECT) values('P-2','OPL-1','2',0);  
insert into PRIZE_PARAMETERS(PARAMETER_ID,PRIZE_LOGIC_ID,PARAMETER_NAME,IS_PRIZE_OBJECT) values('P-3','OPL-1','3',0);  
insert into PRIZE_PARAMETERS(PARAMETER_ID,PRIZE_LOGIC_ID,PARAMETER_NAME,IS_PRIZE_OBJECT) values('P-4','OPL-1','4',0);  
insert into PRIZE_PARAMETERS(PARAMETER_ID,PRIZE_LOGIC_ID,PARAMETER_NAME,IS_PRIZE_OBJECT) values('P-5','OPL-1','5',0);  
insert into PRIZE_PARAMETERS(PARAMETER_ID,PRIZE_LOGIC_ID,PARAMETER_NAME,IS_PRIZE_OBJECT) values('P-6','OPL-1','7',0);  
insert into PRIZE_PARAMETERS(PARAMETER_ID,PRIZE_LOGIC_ID,PARAMETER_NAME,IS_PRIZE_OBJECT) values('P-7','OPL-1','8',0);     
  
-- ============================================================== --
-- BD_PRIZE_PARAMETER                                             --
-- ============================================================== --
-- use by second chance winner analysis
insert into OBJECT_PRIZE_PARAMETERS(ID,PRIZE_LOGIC_ID,BD_PRIZE_OBJECT_ID,PRIZE_LEVEL,CREATE_TIME,UPDATE_TIME)
	values('PP-1', 'OPL-1', 'BPO-1',1,sysdate, sysdate);
insert into OBJECT_PRIZE_PARAMETERS(ID,PRIZE_LOGIC_ID,BD_PRIZE_OBJECT_ID,PRIZE_LEVEL,CREATE_TIME,UPDATE_TIME)
	values('PP-2', 'OPL-1', 'BPO-2',2,sysdate, sysdate);
insert into OBJECT_PRIZE_PARAMETERS(ID,PRIZE_LOGIC_ID,BD_PRIZE_OBJECT_ID,PRIZE_LEVEL,CREATE_TIME,UPDATE_TIME)
	values('PP-3', 'OPL-1', 'BPO-3',3,sysdate, sysdate);
insert into OBJECT_PRIZE_PARAMETERS(ID,PRIZE_LOGIC_ID,BD_PRIZE_OBJECT_ID,PRIZE_LEVEL,CREATE_TIME,UPDATE_TIME)
	values('PP-4', 'OPL-1', 'BPO-4',4,sysdate, sysdate);
insert into OBJECT_PRIZE_PARAMETERS(ID,PRIZE_LOGIC_ID,BD_PRIZE_OBJECT_ID,PRIZE_LEVEL,CREATE_TIME,UPDATE_TIME)
	values('PP-5', 'OPL-1', 'BPO-5',5,sysdate, sysdate);
insert into OBJECT_PRIZE_PARAMETERS(ID,PRIZE_LOGIC_ID,BD_PRIZE_OBJECT_ID,PRIZE_LEVEL,CREATE_TIME,UPDATE_TIME)
	values('PP-6', 'OPL-1', 'BPO-6',6,sysdate, sysdate);
insert into OBJECT_PRIZE_PARAMETERS(ID,PRIZE_LOGIC_ID,BD_PRIZE_OBJECT_ID,PRIZE_LEVEL,CREATE_TIME,UPDATE_TIME)
	values('PP-7', 'OPL-1', 'BPO-7',7,sysdate, sysdate);
insert into OBJECT_PRIZE_PARAMETERS(ID,PRIZE_LOGIC_ID,BD_PRIZE_OBJECT_ID,PRIZE_LEVEL,CREATE_TIME,UPDATE_TIME)
	values('PP-8', 'OPL-1', 'BPO-8',8,sysdate, sysdate);

	
-------------------------------------------------------------------
-- DAILY_CASH PRIZE
-------------------------------------------------------------------	
insert into WINNING_DAILY_CASH(
    id, version, create_time, ticket_serialno,game_instance_id,prize_level, prize_number,is_valid,BD_PRIZE_LEVEL_ID
) values(
    'WO-1',1,sysdate,'S-123456','GII-111',4,1,1,'PL-4'
);    
insert into WINNING_DAILY_CASH(
    id, version, create_time, ticket_serialno,game_instance_id,prize_level, prize_number,is_valid,BD_PRIZE_LEVEL_ID
) values(
    'WO-2',1,sysdate,'S-123456','GII-111',7,1,1,'PL-7'
); 	
insert into WINNING_DAILY_CASH(
    id, version, create_time, ticket_serialno,game_instance_id,prize_level, prize_number,is_valid,BD_PRIZE_LEVEL_ID
) values(
    'WO-3',1,sysdate,'S-123456','GII-116',7,1,1,'PL-7'
); 	

-- ============================================================== --
-- BD_PRIZE_GROUP_ITEM                                            --
-- ============================================================== --
-- prize type definition: 1,cash; 2,object, 3:cash+object
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-8', 'BPG-1', '8', 19, 2
);
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-15', 'BPG-1', '1', 1, 1
);
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-16', 'BPG-1', '2', 1, 1
);
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-17', 'BPG-1', '3', 1, 1
);
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-18', 'BPG-1', '4',1, 1
);
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-19', 'BPG-1', '5', 1, 1
);
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-20', 'BPG-1', '6', 1, 1
);
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-21', 'BPG-1', '7', 1, 1
);
insert into bd_prize_group_item(
    id, bd_prize_group_id, prize_level,game_type,prize_type
) values(
    'LOTTO-22', 'BPG-1', '8', 1, 1
);
	
-------------------------------------------------------------------
-- ENCRYPTION
------------------------------------------------------------------- 
update te_ticket set serial_no='9pkxn/npytVqVbOF5fPlsg==' where serial_no='S-123456';
update te_ticket set serial_no='Dwl8yOheqKjvpIPttu67Ag==' where serial_no='S-123456-a';
update te_ticket set serial_no='XuwwI3eLJ5RTxe2TtewDGQ==' where serial_no='S-654321';
update te_ticket set serial_no='2nwUFkQGi64oJklaIP8Aaw==' where serial_no='S-888888';
update te_ticket set serial_no='9PxcXjxUqio2KW08CjtE7Q==' where serial_no='S-111111';
update te_ticket set serial_no='SMAmjvBG5cPXXLYTjmnJLw==' where serial_no='S-999999';

-- Update te_lotto_entry
update te_lotto_entry set TICKET_SERIALNO='9pkxn/npytVqVbOF5fPlsg==' where TICKET_SERIALNO='S-123456';
update te_lotto_entry set TICKET_SERIALNO='Dwl8yOheqKjvpIPttu67Ag==' where TICKET_SERIALNO='S-123456-a';
update te_lotto_entry set TICKET_SERIALNO='XuwwI3eLJ5RTxe2TtewDGQ==' where TICKET_SERIALNO='S-654321';
update te_lotto_entry set TICKET_SERIALNO='2nwUFkQGi64oJklaIP8Aaw==' where TICKET_SERIALNO='S-888888';
update te_lotto_entry set TICKET_SERIALNO='9PxcXjxUqio2KW08CjtE7Q==' where TICKET_SERIALNO='S-111111';
update te_lotto_entry set TICKET_SERIALNO='SMAmjvBG5cPXXLYTjmnJLw==' where TICKET_SERIALNO='S-999999';

-- Update payout
update payout set TICKET_SERIALNO='9pkxn/npytVqVbOF5fPlsg==' where TICKET_SERIALNO='S-123456';
update payout set TICKET_SERIALNO='Dwl8yOheqKjvpIPttu67Ag==' where TICKET_SERIALNO='S-123456-a';
update payout set TICKET_SERIALNO='XuwwI3eLJ5RTxe2TtewDGQ==' where TICKET_SERIALNO='S-654321';
update payout set TICKET_SERIALNO='2nwUFkQGi64oJklaIP8Aaw==' where TICKET_SERIALNO='S-888888';
update payout set TICKET_SERIALNO='9PxcXjxUqio2KW08CjtE7Q==' where TICKET_SERIALNO='S-111111';
update payout set TICKET_SERIALNO='SMAmjvBG5cPXXLYTjmnJLw==' where TICKET_SERIALNO='S-999999';

-- Update te_transaction
update te_transaction set TICKET_SERIAL_NO='9pkxn/npytVqVbOF5fPlsg==' where TICKET_SERIAL_NO='S-123456';
update te_transaction set TICKET_SERIAL_NO='Dwl8yOheqKjvpIPttu67Ag==' where TICKET_SERIAL_NO='S-123456-a';
update te_transaction set TICKET_SERIAL_NO='XuwwI3eLJ5RTxe2TtewDGQ==' where TICKET_SERIAL_NO='S-654321';
update te_transaction set TICKET_SERIAL_NO='2nwUFkQGi64oJklaIP8Aaw==' where TICKET_SERIAL_NO='S-888888';
update te_transaction set TICKET_SERIAL_NO='9PxcXjxUqio2KW08CjtE7Q==' where TICKET_SERIAL_NO='S-111111';
update te_transaction set TICKET_SERIAL_NO='SMAmjvBG5cPXXLYTjmnJLw==' where TICKET_SERIAL_NO='S-999999';

-- Update winning
update winning set TICKET_SERIALNO='9pkxn/npytVqVbOF5fPlsg==' where TICKET_SERIALNO='S-123456';
update winning set TICKET_SERIALNO='Dwl8yOheqKjvpIPttu67Ag==' where TICKET_SERIALNO='S-123456-a';
update winning set TICKET_SERIALNO='XuwwI3eLJ5RTxe2TtewDGQ==' where TICKET_SERIALNO='S-654321';
update winning set TICKET_SERIALNO='2nwUFkQGi64oJklaIP8Aaw==' where TICKET_SERIALNO='S-888888';
update winning set TICKET_SERIALNO='9PxcXjxUqio2KW08CjtE7Q==' where TICKET_SERIALNO='S-111111';
update winning set TICKET_SERIALNO='SMAmjvBG5cPXXLYTjmnJLw==' where TICKET_SERIALNO='S-999999';

-- Update winning_object
update winning_object set TICKET_SERIALNO='9pkxn/npytVqVbOF5fPlsg==' where TICKET_SERIALNO='S-123456';
update winning_object set TICKET_SERIALNO='Dwl8yOheqKjvpIPttu67Ag==' where TICKET_SERIALNO='S-123456-a';
update winning_object set TICKET_SERIALNO='XuwwI3eLJ5RTxe2TtewDGQ==' where TICKET_SERIALNO='S-654321';
update winning_object set TICKET_SERIALNO='2nwUFkQGi64oJklaIP8Aaw==' where TICKET_SERIALNO='S-888888';
update winning_object set TICKET_SERIALNO='9PxcXjxUqio2KW08CjtE7Q==' where TICKET_SERIALNO='S-111111';
update winning_object set TICKET_SERIALNO='SMAmjvBG5cPXXLYTjmnJLw==' where TICKET_SERIALNO='S-999999';

-- Update Dailycash_winning_object
update WINNING_DAILY_CASH set TICKET_SERIALNO='9pkxn/npytVqVbOF5fPlsg==' where TICKET_SERIALNO='S-123456';
update WINNING_DAILY_CASH set TICKET_SERIALNO='Dwl8yOheqKjvpIPttu67Ag==' where TICKET_SERIALNO='S-123456-a';    

commit;
