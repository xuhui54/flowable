-- Drop table

-- ɾ���ⲿ��
-- DROP EXTERNAL TABLE "user".archive_feature_wb;
-- �����ⲿ��
create  external  table  test.user.archive_feature_wb (
	like test.user.archive_feature
)
LOCATION (
	'gpfdist://192.168.206.180:8081/archive_feature.csv'
) 
FORMAT 'csv' ( delimiter ',' null '' escape '"' quote '"'  )
ENCODING 'UTF8';


--
create    table  test.user.archive_feature_1 (
	like test.user.archive_feature
);

insert into "user".archive_feature_1 select * from test."user".archive_feature where "archiveId"='330108111907120000008'





--��ѯ����
select * from test."user".archive_feature_wb where "archiveId"='330108111907120000008'

select count(0) from test."user".archive_feature_wb where  "deptCode" is null
update test."user".archive_feature_wb  set "deptCode"="areaCode" where "deptCode" is null

--�ⲿ��ͬ��������
insert into "user".archive_feature
select * from test."user".archive_feature_wb

where  "deptCode"  <>''  

--
select count(*) from test."user".archive_feature_wb where  "deptCode"  <>''  
--
select count(*) from test."user".archive_feature where  "deptCode"  is null   

update test."user".archive_feature  set "deptCode"="areaCode" where "deptCode" is null



select * from "user".archive_feature  where   "archiveId"='330112190219903047018' and "deptCode"='001008001017003'  and "areaCode"='330112'

--�����ѯ
select "areaCode","deptCode" ,"applyFrom" , "completeType",count(*) from  "user".archive_feature  group by "areaCode","deptCode", "applyFrom" , "completeType"
--ifelse
select if "applyFrom"=any(array[0,3,4,5,8]) then sum(1) else sum(0)  end if  from  "user".archive_feature_1


--��ѯ���С
select pg_relation_size('user.sys_role_permission_nb2')

--�����ռ�
vacuum full "user".archive_feature;
--�ռ������Ż�ִ�мƻ�
analyze "user".archive_feature;
--�鿴�ֽ��¼
select gp_segment_id,count(*) from "user".archive_feature group by gp_segment_id;



--DISTRIBUTED?BY?("archiveId","deptCode","areaCode");

-- Permissions
ALTER EXTERNAL TABLE "user".archive_feature_wb OWNER TO gpmon;
GRANT ALL ON TABLE "user".archive_feature TO gpmon;

--�޸ķֲ���
alter table test.user.archive_feature set DISTRIBUTED BY ("deptCode", "areaCode", "archiveId");
--�ֲ���
alter table test.user.archive_feature set distributed by ("archiveId","areaCode","deptCode");
ALTER TABLE "user".archive_feature ADD CONSTRAINT archive_feature_pk PRIMARY KEY ("archiveId","areaCode","deptCode");


        
        
