create or replace package pkg_scalping_tester is

  -- ���̶���
  procedure load_trading_data(i_table_name varchar2, i_len number);
  procedure get_profit_slice(i_tp_level number, i_sl_level number, i_len number);
  procedure get_rsi_trading(i_long_rsi number, i_short_rsi number);
  procedure get_rsi_trading_stat;
  procedure get_data(i_table_name varchar2);
  procedure test01;
  procedure test02;
  procedure test03;

-- ������ص����ݽṹ
/* 
  -- Create sequence 
  create sequence SEQ_LOG
  minvalue 1
  maxvalue 999999999999999999999999999
  start with 1
  increment by 1
  cache 20;
  
  -- Create table
  create table TB_ST_LOG
  (
    LOG_ID   NUMBER,
    LOG_DATE DATE,
    LOG_MSG  VARCHAR2(4000)
  );
  -- Create table
  create table TB_ST_PROFIT_SLICE
  (
    TP_LEVEL NUMBER,
    SL_LEVEL NUMBER,
    LEN      NUMBER,
    TYPE     VARCHAR2(10),
    TIME     DATE,
    N        NUMBER,
    N1       NUMBER,
    TP       NUMBER,
    SL       NUMBER,
    CL       NUMBER,
    PROFIT   NUMBER
  );
  
  create table TB_ST_PROFIT_SLICE_BAK
  (
    TP_LEVEL NUMBER,
    SL_LEVEL NUMBER,
    LEN      NUMBER,
    TYPE     VARCHAR2(10),
    TIME     DATE,
    N        NUMBER,
    N1       NUMBER,
    TP       NUMBER,
    SL       NUMBER,
    CL       NUMBER,
    PROFIT   NUMBER
  );
  
  create table TB_ST_PROFIT_SLICE_LONG
  (
    N  NUMBER,
    N1 NUMBER,
    TP NUMBER,
    SL NUMBER,
    CL NUMBER
  );
  create index TB_ST_PROFIT_SLICE_LONG_i1 on TB_ST_PROFIT_SLICE_LONG (N);
  
  create table TB_ST_PROFIT_SLICE_SHORT
  (
    N  NUMBER,
    N1 NUMBER,
    TP NUMBER,
    SL NUMBER,
    CL NUMBER
  );
  create index TB_ST_PROFIT_SLICE_SHORT_I1 on TB_ST_PROFIT_SLICE_SHORT (N);
  
  -- Create table
  create table TB_ST_RSI_TRADING
  (
    TIME DATE,
    N    NUMBER,
    TYPE varchar2(10),
    RSI  NUMBER
  );
  
  create table TB_ST_RSI_TRADING_BAK
  (
    TIME DATE,
    N    NUMBER,
    TYPE varchar2(10),
    RSI  NUMBER
  );
  
  -- Create table
  create table TB_ST_TRADING_DATA
  (
    TIME   DATE,
    OPEN   NUMBER,
    CLOSE  NUMBER,
    HIGH   NUMBER,
    LOW    NUMBER,
    VOLUME NUMBER,
    ASK    NUMBER,
    BID    NUMBER,
    RSI    NUMBER,    
    RSI1   NUMBER,
    N      NUMBER         
  );
  create index TB_ST_TRADING_DATA_I1 on TB_ST_TRADING_DATA (N);
  
  create table TB_ST_TRADING_DATA_MIX
  (
    TIME DATE,
    N    NUMBER,
    ASK  NUMBER,
    BID  NUMBER,
    N1   NUMBER,
    ASK1 NUMBER,
    BID1 NUMBER
  ); 

  create table tb_st_rsi_trading_detail
  (
    TP_LEVEL     NUMBER,
    SL_LEVEL     NUMBER,
    LEN          NUMBER,
    TYPE         VARCHAR2(10),
    TIME         DATE,
    N            NUMBER,
    N1           NUMBER,
    TP           NUMBER,
    SL           NUMBER,
    CL           NUMBER,
    PROFIT       NUMBER,
    HH24         VARCHAR2(2),
    RSI          NUMBER,
    G            NUMBER,
    GCNT         NUMBER,
    M            NUMBER,
    TOTAL_PROFIT NUMBER
  )
  create index TB_ST_RSI_TRADING_DETAIL_I1 on TB_ST_RSI_TRADING_DETAIL (G);
  
  create table tb_st_rsi_trading_detail_fit
  (
    G   NUMBER,
    CNT NUMBER,
    B1  NUMBER,
    B0  NUMBER
  );
  
  create table tb_st_rsi_trading_detail_1
  (
    TP_LEVEL             NUMBER,
    SL_LEVEL             NUMBER,
    LEN                  NUMBER,
    TYPE                 VARCHAR2(10),
    TIME                 DATE,
    N                    NUMBER,
    N1                   NUMBER,
    TP                   NUMBER,
    SL                   NUMBER,
    CL                   NUMBER,
    PROFIT               NUMBER,
    HH24                 VARCHAR2(2),
    RSI                  NUMBER,
    G                    NUMBER,
    GCNT                 NUMBER,
    M                    NUMBER,
    TOTAL_PROFIT         NUMBER,
    PREDICT_TOTAL_PROFIT NUMBER,
    DEVIATION            NUMBER
  );
  create index tb_st_rsi_trading_detail_1_i1 on tb_st_rsi_trading_detail_1(g);
  
  create table tb_st_rsi_trading_stat
  (
    G             NUMBER,
    TP_LEVEL      NUMBER,
    SL_LEVEL      NUMBER,
    LEN           NUMBER,
    TYPE          VARCHAR2(10),
    HH24          VARCHAR2(2),
    RSI           NUMBER,
    CNT           NUMBER,
    TP            NUMBER,
    SL            NUMBER,
    CL            NUMBER,
    PROFIT        NUMBER,
    TP_PROFIT     NUMBER,
    SL_PROFIT     NUMBER,
    CL_PROFIT     NUMBER,
    TP_PCT        NUMBER,
    SL_PCT        NUMBER,
    CL_PCT        NUMBER,
    DEVIATION     NUMBER,
    AVG_DEVIATION NUMBER,
    R1            NUMBER,
    R2            NUMBER,
    R3            NUMBER
  );
  alter table tb_st_trading_data nologging;
  alter table tb_st_trading_data_mix nologging;
  alter table tb_st_profit_slice_long nologging;
  alter table tb_st_profit_slice_short nologging;
  alter table tb_st_profit_slice nologging;
  alter table tb_st_rsi_trading nologging;
  alter table tb_st_rsi_trading_detail nologging;
  alter table tb_st_rsi_trading_detail_fit nologging;
  alter table tb_st_rsi_trading_detail_1 nologging;
  alter table tb_st_rsi_trading_stat nologging;  
  alter table tb_st_profit_slice_bak nologging;
  alter table tb_st_rsi_trading_bak nologging;
  
  alter index tb_st_profit_slice_short_i1 nologging;
  alter index tb_st_profit_slice_long_i1 nologging;
  alter index tb_st_rsi_trading_detail_i1 nologging;
  alter index tb_st_trading_data_i1 nologging;
  alter index tb_st_rsi_trading_detail_1_i1 nologging;
  
  */

end pkg_scalping_tester;
/
create or replace package body pkg_scalping_tester is

  /*
    �������⣺                                                            ��1��
    1. ��֧���ź�������ʹ�ý���ͷ���ź�
    2. ��������ͷ������
    -- ������������ֻҪ�޸�get_rsi_trading�����ʵ����ƿ��Խ��
    -- �������������������⣬���γ�һ���Ƚ������Ľ���ϵͳ����������  
    
    
    ���õĽ����� : type,hh24
    ������� : rsi   (��Դ�ڹ�����)
    ������� : sl,tp (��Դ�ڷ��տ���)    
    ������� : avg_profit,tp_pct,avg_deviate_rate,k������
    
    
    һЩ�м�ֵ���뷨��               
    1����һ������������ʱrsi�仯ʱ��tl-sl������Ӧ�Ķ�ά��������仯ͼ      
      ��rsi,sl,tp��ά������,��ɫ��ʾƽ�����������                       ��2��
    2������ͬ�·����ݷֱ�����������Ƭ��������Ѱ����ͬ��Ƭλ�ã�
    �Ĳ����·ݵ�ӯ�������������ƽ��ӯ��������������������             ��3��  
    ���������Կ��ǽ�����ϣ�
  */

  procedure log(i_msg varchar2) is
  begin
    insert into tb_st_log
      select seq_log.nextval, sysdate, i_msg from dual;
    commit;
  end;

  procedure clear_log is
  begin
    execute immediate 'truncate table tb_st_log';
  end;

  --  ���뽻������
  procedure load_trading_data(i_table_name varchar2, i_len number) is
    v_column_name varchar2(4000);
  begin
    log('load_trading_data(' || i_table_name || ',' || to_char(i_len) || '):��ʼ');
    -- ��ȡ���ݱ�����ͬ���ֶ�
    select wm_concat(column_name)
      into v_column_name
      from user_tab_cols a
     where table_name = 'TB_ST_TRADING_DATA'
       and exists (select 1
              from user_tab_cols b
             where table_name = upper(i_table_name)
               and b.column_name = a.column_name)
     order by column_id;
    execute immediate 'truncate table tb_st_trading_data';
    execute immediate '
    insert /*+append*/ into tb_st_trading_data(' ||
                      v_column_name || ')
      select ' || v_column_name || ' from ' || i_table_name;
    commit;
  
    -- ��������֮����ض��������ڵ����ݽ��й���
    execute immediate 'truncate table tb_st_trading_data_mix';
    insert /*+append*/
    into tb_st_trading_data_mix
      select a.time, a.n, a.ask, a.bid, b.n n1, b.ask ask1, b.bid bid1
        from tb_st_trading_data a, tb_st_trading_data b
       where a.n < b.n
         and b.n <= a.n + i_len;
    commit;
    log('load_trading_data:����');
  end;

  -- ����ӯ����Ƭ
  procedure get_profit_slice(i_tp_level number, i_sl_level number, i_len number) is
  begin
    log('get_profit_slice(' || to_char(i_tp_level) || ',' || to_char(i_sl_level) || ',' ||
        to_char(i_len) || '):��ʼ');
    -- �������ཻ�׵�ӯ����Ƭ
    execute immediate 'truncate table tb_st_profit_slice_long';
    insert /*+append*/
    into tb_st_profit_slice_long
      select n, min(n1) n1, 1 tp, 0 sl, 0 cl
        from tb_st_trading_data_mix
       where (bid1 - ask) * 10000 > i_tp_level
       group by n
      union
      select n, min(n1) n1, 0 tp, 1 sl, 0 cl
        from tb_st_trading_data_mix
       where (bid1 - ask) * 10000 < -i_sl_level
       group by n
      union
      select n, max(n1) n1, 0 tp, 0 sl, 1 cl
        from tb_st_trading_data_mix
       where n1 - n <= i_len
       group by n;
    commit;
    delete /*+rule*/
    from tb_st_profit_slice_long a
     where a.n1 <> (select min(b.n1) from tb_st_profit_slice_long b where b.n = a.n);
    delete /*+rule*/
    from tb_st_profit_slice_long a
     where a.cl <> (select min(b.cl) from tb_st_profit_slice_long b where b.n = a.n);
    commit;
  
    -- �������ս��׵�ӯ����Ƭ
    execute immediate 'truncate table tb_st_profit_slice_short';
    insert /*+append*/
    into tb_st_profit_slice_short
      select n, min(n1) n1, 1 tp, 0 sl, 0 cl
        from tb_st_trading_data_mix
       where (bid - ask1) * 10000 > i_tp_level
       group by n
      union
      select n, min(n1) n1, 0 tp, 1 sl, 0 cl
        from tb_st_trading_data_mix
       where (bid - ask1) * 10000 < -i_sl_level
       group by n
      union
      select n, max(n1) n1, 0 tp, 0 sl, 1 cl
        from tb_st_trading_data_mix
       where n1 - n <= i_len
       group by n;
    commit;
    delete /*+rule*/
    from tb_st_profit_slice_short a
     where a.n1 <> (select min(b.n1) from tb_st_profit_slice_short b where b.n = a.n);
    delete /*+rule*/
    from tb_st_profit_slice_short a
     where a.cl <> (select min(b.cl) from tb_st_profit_slice_short b where b.n = a.n);
    commit;
  
    -- �ϲ���������
    execute immediate 'truncate table tb_st_profit_slice';
    insert /*+append*/
    into tb_st_profit_slice
      select i_tp_level,
             i_sl_level,
             i_len,
             'long' type,
             b.time,
             a.n,
             a.n1,
             a.tp,
             a.sl,
             a.cl,
             (c.bid - b.ask) * 10000 profit
        from tb_st_profit_slice_long a, tb_st_trading_data b, tb_st_trading_data c
       where a.n = b.n(+)
         and a.n1 = c.n(+);
    commit;
    insert /*+append*/
    into tb_st_profit_slice
      select i_tp_level,
             i_sl_level,
             i_len,
             'short' type,
             b.time,
             a.n,
             a.n1,
             a.tp,
             a.sl,
             a.cl,
             (b.bid - c.ask) * 10000 profit
        from tb_st_profit_slice_short a, tb_st_trading_data b, tb_st_trading_data c
       where a.n = b.n(+)
         and a.n1 = c.n(+);
    commit;
  
    log('get_profit_slice:����');
  end;

  -- RSI���׼�¼������
  procedure get_rsi_trading(i_long_rsi number, i_short_rsi number) is
  begin
    log('get_rsi_trading(' || to_char(i_long_rsi) || ',' || to_char(i_short_rsi) ||
        '):��ʼ');
    /* -- RSI���ɹ���1  
    execute immediate 'truncate table tb_st_rsi_trading';
    insert \*+append*\
    into tb_st_rsi_trading
      select a.time, a.n, 'long' type, i_long_rsi
        from tb_st_trading_data a, tb_st_trading_data b
       where a.n = b.n + 1
         and b.rsi <= i_long_rsi
         and a.rsi > i_long_rsi
      union all
      select a.time, a.n, 'short' type, i_short_rsi
        from tb_st_trading_data a, tb_st_trading_data b
       where a.n = b.n + 1
         and b.rsi >= i_short_rsi
         and a.rsi < i_short_rsi;
    commit;
    */
    -- RSI���ɹ���2
    execute immediate 'truncate table tb_st_rsi_trading';
    insert /*+append*/
    into tb_st_rsi_trading
      select a.time, a.n, 'long' type, i_long_rsi
        from tb_st_trading_data a
       where a.rsi1 <= i_long_rsi
         and a.rsi > i_long_rsi
      union all
      select a.time, a.n, 'short' type, i_short_rsi
        from tb_st_trading_data a
       where a.rsi1 >= i_short_rsi
         and a.rsi < i_short_rsi;
    commit;
    log('get_rsi_trading:����');
  end;

  procedure get_rsi_trading_stat is
  begin
    log('get_rsi_trading_stat:��ʼ');
  
    -- �������׼�¼�Ͷ�Ӧ�Ļ�����Ƭ,�γɽ�����ϸ
    execute immediate 'truncate table tb_st_rsi_trading_detail';
    insert /*+append*/
    into tb_st_rsi_trading_detail
      select a.*,
             to_char(a.time, 'hh24') hh24,
             b.rsi,
             dense_rank() over(order by a.tp_level, a.sl_level, a.len, a.type, to_char(a.time, 'hh24'), b.rsi) g,
             count(*) over(partition by a.tp_level, a.sl_level, a.len, a.type, to_char(a.time, 'hh24'), b.rsi) gcnt,
             row_number() over(partition by a.tp_level, a.sl_level, a.len, a.type, to_char(a.time, 'hh24'), b.rsi order by a.n) m,
             sum(profit) over(partition by a.tp_level, a.sl_level, a.len, a.type, to_char(a.time, 'hh24'), b.rsi order by a.n) total_profit
        from tb_st_profit_slice_bak a, tb_st_rsi_trading_bak b
       where a.n = b.n
         and a.type = b.type;
    commit;
  
    -- ͨ��һԪ���Իع���ϳ�"���״���--�ۼ�����"��ֱ�߷���
    execute immediate 'truncate table tb_st_rsi_trading_detail_fit';
    insert /*+append*/
    into tb_st_rsi_trading_detail_fit
      select g,
             count(*) cnt,
             sum((x - x0) * (y - y0)) / sum((x - x0) * (x - x0)) b1,
             avg(y) - sum((x - x0) * (y - y0)) / sum((x - x0) * (x - x0)) * avg(x) b0
        from (select g,
                     m x,
                     total_profit y,
                     avg(m) over(partition by g) x0,
                     avg(total_profit) over(partition by g) y0
                from tb_st_rsi_trading_detail
               where gcnt > 1)
       group by g;
    commit;
  
    --  ����ÿ�ʽ��׵����
    execute immediate 'truncate table tb_st_rsi_trading_detail_1';
    insert /*+append*/
    into tb_st_rsi_trading_detail_1
      select a.*,
             b0 + b.b1 * a.m predict_total_profit,
             abs(total_profit - (b0 + b.b1 * a.m)) deviation,
             b.b1 k
        from tb_st_rsi_trading_detail a, tb_st_rsi_trading_detail_fit b
       where a.g = b.g(+);
    commit;
  
    -- �Խ��׼�¼����ͳ��
    execute immediate 'truncate table tb_st_rsi_trading_stat';
    insert /*+append*/
    into tb_st_rsi_trading_stat
      select g,
             tp_level,
             sl_level,
             len,
             type,
             hh24,
             rsi,
             count(*) cnt,
             sum(tp) tp,
             sum(sl) sl,
             sum(cl) cl,
             sum(profit) profit,
             sum(profit) / count(*) avg_profit,
             sum(tp * profit) tp_profit,
             sum(sl * profit) sl_profit,
             sum(cl * profit) cl_profit,
             sum(tp) / count(*) tp_pct,
             sum(sl) / count(*) sl_pct,
             sum(cl) / count(*) cl_pct,
             sum(deviation) deviation,
             sum(deviation) / count(*) avg_deviation,
             sum(deviation * deviation) / count(*) avg_deviation_square,
             sum(deviation / abs(decode(total_profit, 0, null, total_profit))) /
             count(*) avg_deviate_rate,
             max(k) k
      --row_number() over(order by sum(profit) desc) r1,
      --row_number() over(order by sum(tp) / count(*) desc) r2,
      --row_number() over(order by sum(deviation) / count(*)) r3
        from tb_st_rsi_trading_detail_1
       group by g, tp_level, sl_level, len, type, hh24, rsi;
    commit;
  
    log('get_rsi_trading_stat:����');
  end;

  procedure get_data(i_table_name varchar2) is
    i number;
    j number;
  begin
    log('get_data:��ʼ');
  
    -- ���뽨���ԭʼ����
    --load_trading_data('tb_hfmarketsltd_eurcad_m1_real', 120);
    load_trading_data(i_table_name, 120);
  
    -- ��������ӯ����Ƭ����    
    execute immediate 'truncate table tb_st_profit_slice_bak';
    i := 0.5;
    while i <= 10 loop
      j := 0.5;
      while j <= 30 loop
        get_profit_slice(i, j, 120);
        insert /*+append*/
        into tb_st_profit_slice_bak
          select * from tb_st_profit_slice;
        commit;
        j := j + .5;
      end loop;
      i := i + .5;
    end loop;
  
    -- ��������RSI���׵�
    execute immediate 'truncate table tb_st_rsi_trading_bak';
    i := 5;
    while i <= 35 loop
      get_rsi_trading(i, 100 - i);
      insert /*+append*/
      into tb_st_rsi_trading_bak
        select * from tb_st_rsi_trading;
      commit;
      i := i + 1;
    end loop;
  
    -- ��ȡ��������ͳ�ƽ��
    get_rsi_trading_stat;
  
    log('get_data:����');
  end;

  procedure test01 is
  begin
    clear_log;
    log('test01:��ʼ');
    -- ����201306����
    get_data('tb_hfltd_eurcad_m1_42p_201306');
    execute immediate '
      create table tb_st_rsi_trading_stat_201306 as select * from tb_st_rsi_trading_stat ';
    execute immediate '      
      create table tb_st_rsi_trading_201306 as select * from tb_st_rsi_trading_detail_1 ';
    log('test01:201306���');
  
    -- ����201307����
    get_data('tb_hfltd_eurcad_m1_42p_201307');
    execute immediate '
      create table tb_st_rsi_trading_stat_201307 as select * from tb_st_rsi_trading_stat ';
    execute immediate '      
      create table tb_st_rsi_trading_201307 as select * from tb_st_rsi_trading_detail_1 ';
    log('test01:201307���');
  
    -- ����201308����
    get_data('tb_hfltd_eurcad_m1_42p_201308');
    execute immediate '
      create table tb_st_rsi_trading_stat_201308 as select * from tb_st_rsi_trading_stat ';
    execute immediate '      
      create table tb_st_rsi_trading_201308 as select * from tb_st_rsi_trading_detail_1 ';
    log('test01:201308���');
    log('test01:����');
  end;

  procedure test02 is
  begin
    clear_log;
    log('test02:��ʼ');
    -- ����30p����
    get_data('tb_hfmarketsltd_eurcad_m1_30p');
    execute immediate '
      create table tb_st_rsi_trading_stat_30p as select * from tb_st_rsi_trading_stat ';
    execute immediate '      
      create table tb_st_rsi_trading_detail_30p as select * from tb_st_rsi_trading_detail_1 ';
    log('test01:30p���');
  
    -- ����35p����
    get_data('tb_hfmarketsltd_eurcad_m1_35p');
    execute immediate '
      create table tb_st_rsi_trading_stat_35p as select * from tb_st_rsi_trading_stat ';
    execute immediate '      
      create table tb_st_rsi_trading_detail_35p as select * from tb_st_rsi_trading_detail_1 ';
    log('test01:35p���');
  
    -- ����40p����
    get_data('tb_hfmarketsltd_eurcad_m1_40p');
    execute immediate '
      create table tb_st_rsi_trading_stat_40p as select * from tb_st_rsi_trading_stat ';
    execute immediate '      
      create table tb_st_rsi_trading_detail_40p as select * from tb_st_rsi_trading_detail_1 ';
    log('test01:40p���');
  
    log('test02:����');
  end;

  procedure test03 is
  begin
    --load_trading_data('duh0829_1',120);
    --load_trading_data('duh0829_2',120);
    clear_log;
    get_data('duh0829_1');
  end;

/*
-- ���ݼ��
select n,type,rsi,count(*) from tb_st_rsi_trading_bak group by n,type,rsi having count(*) > 1;
select tp_level, sl_level, len, type, n, count(*)
  from tb_st_profit_slice_bak
 group by tp_level, sl_level, len, type, n
having count(*) > 1;
*/

/*
-- ͳ�ƽ��
select a.tp_level,
       a.sl_level,
       a.len,
       a.type,
       to_char(a.time, 'hh24') hh24,
       b.rsi,
       count(*) cnt,
       sum(tp) tp,
       sum(sl) sl,
       sum(cl) cl,
       sum(profit) profit,
       sum(tp * profit) tp_profit,
       sum(sl * profit) sl_profit,
       sum(cl * profit) cl_profit,
       sum(tp)/count(*) tp_pct,
       sum(sl)/count(*) sl_pct,
       sum(cl)/count(*) cl_pct
  from tb_st_profit_slice_bak a, tb_st_rsi_trading_bak b
 where a.n = b.n
   and a.type = b.type
 group by a.tp_level,
          a.sl_level,
          a.len,
          a.type,
          to_char(a.time, 'hh24'),
          b.rsi;
*/

/*
select a.*,
       to_char(a.time, 'hh24') hh24,
       b.rsi,
       dense_rank() over(ORDER BY a.tp_level, a.sl_level, a.len, a.type, to_char(a.time, 'hh24'), b.rsi) g,
       row_number() over(partition by a.tp_level, a.sl_level, a.len, a.type, to_char(a.time, 'hh24'), b.rsi order by a.n) m
  from tb_st_profit_slice_bak a, tb_st_rsi_trading_bak b
 where a.n = b.n
   and a.type = b.type;
*/

/*
# һԪ���Իع�
x = cars$speed;
y = cars$dist;
# ʹ�ù�ʽ�ֹ�����
B1=sum((x-mean(x))*(y-mean(y)))/sum((x-mean(x))^2);
B0=mean(y)-B1*mean(x);
paste("ģ�� : Y = ",round(B0,3)," + ",round(B1,3),"X",sep = "");
# ʹ��lm��������
lm(y~x);
*/

/*
select tp_level,
       sl_level,
       rsi,
       cnt,
       profit,
       tp_pct,
       profit / cnt avg_profit,
       avg_deviate_rate,
       k
  from tb_st_rsi_trading_stat
 where type = 'short'
   and hh24 = '00'
   and cnt > 1;
*/

end pkg_scalping_tester;
/