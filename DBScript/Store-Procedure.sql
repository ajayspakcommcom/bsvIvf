USE [BSV_IVF]
GO
/****** Object:  StoredProcedure [BSV_IVF].[EUSP_GET_COMPETITION_REPORT_FOR_EXCEL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BSV_IVF].[EUSP_GET_COMPETITION_REPORT_FOR_EXCEL]   
( 
    @month int, 
    @year int 
) 
 AS   
 BEGIN   
  
     declare @dateAddedFor smallDateTime     
    set  @dateAddedFor = (DATEFROMPARTS (@Year, @Month, 1))   
  
select bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,    
  
bsv_ivf.getMyRBMInfo(e.empid) AS RBM,    
  
-- e.empid,     
  
e.firstName as KamName, e.Designation,     
  

  
c.CENTRENAME as centreName,  c.DoctorName, 
com.centerId as centerId,        
  
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 1, @month, @year) as 'FOLIGRAF',   
  
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 2, @month, @year) as 'HUMOG',   
  
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 3, @month, @year) as 'ASPORELIX',   
  
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 4, @month, @year) as 'R-HUCOG',   
  
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 5, @month, @year) as 'FOLICULIN',   
  
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 6, @month, @year) as 'AGOTRIG',   
  
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 7, @month, @year) as 'MIDYDROGEN',   
  
     case com.isApproved                        
  
                    when 1 then 'Pending'                        
  
                    when 0 then 'Approved'                        
  
                    when 2 then 'Rejected'                    
  
                end as statusText,    
  
bsv_ivf.getEMPInfo(com.approvedBy) AS ApprovedBy,    
  
isNull(com.approvedOn, '') as ApprovedOn,    
  
bsv_ivf.getEMPInfo(com.rejectedBy) AS RejectedBy,    
  
 com.rejectedOn,    
  
-- com.rejectComments,    
  
com.competitionAddedFor     
  
from tblCompetitions com   
  
inner join tblcustomers c on c.customerID = com.centerId   
  
inner join tblEmployees e on e.empid = com.empId    
  
where    
  
1 = 1   
  
-- and e.empId = 61   
  
 and  competitionAddedFor = @dateAddedFor    
  
-- and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)     
  
group by e.empid, e.firstName, e.Designation,     
  
c.CENTRENAME,  c.DoctorName, com.centerId, com.isApproved,   
  
com.approvedBy, com.approvedOn, com.rejectedBy, com.rejectedOn, com.competitionAddedFor    
  
   
  
 order by e.firstName ASC   
  
   
  
   
  
   
  
END   
  

  
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_add_update_BUSINESS_TRACKER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--    
/*   
    USP_add_update_BUSINESS_TRACKER   
    24, 31, 2, 2023, 7,9,25, 99, 1, 0, "27-12-2022"   
*/    
--------------------------------------------       
-- CREATED BY: GURU SINGH       
-- CREATED DATE: 24-SEP-2022       
--------------------------------------------       
CREATE PROCEDURE [BSV_IVF].[USP_add_update_BUSINESS_TRACKER]       
(   
    @empId int,   
    @hospitalId int,   
    @month int,   
    @year int,   
    @brandId int,   
    @brandGroupId int,   
    @skuId int,   
    @rate FLOAT,   
    @qty int,   
    @isContractApplicable bit  
)   
AS       
SET NOCOUNT on;      
        BEGIN     
            declare @actualEnteredFor smallDateTime    
            set  @actualEnteredFor = (DATEFROMPARTS (@Year, @Month, 1))    
            if exists (select  
             1 from tblhospitalActuals WHERE empId = @empId and brandId = @brandId    
                    and brandGroupId = @brandGroupId and skuId = @skuId and ActualEnteredFor = @actualEnteredFor)   
                BEGIN   
                    -- disable the record  
                    UPDATE tblhospitalActuals set   
                        isDisabled = 1  
                    WHERE empId = @empId and brandId = @brandId    
                    and brandGroupId = @brandGroupId and skuId = @skuId 
                    and ActualEnteredFor = @actualEnteredFor  AND hospitalId = @hospitalId
                    -- insert a new record, this way we'll keep a record of past entry  
                    INSERT into tblhospitalActuals (empId, hospitalId, ActualEnteredFor, brandId, brandGroupId, skuId,    
                    rate, qty, isContractApplicable, isDisabled, finalStatus)   
                    VALUES(@empId, @hospitalId, @actualEnteredFor, @brandId, @brandGroupId, @skuId,    
                    @rate, @qty, @isContractApplicable, 0, 1)   
                    select 'true' as sucess, 'record updated sucessfully' as msg   
                END   
            ELSE   
                BEGIN   
                    INSERT into tblhospitalActuals (empId, hospitalId, ActualEnteredFor, brandId, brandGroupId, skuId,    
                    rate, qty, isContractApplicable, isDisabled, finalStatus)   
                    VALUES(@empId, @hospitalId, @actualEnteredFor, @brandId, @brandGroupId, @skuId,    
                    @rate, @qty, @isContractApplicable, 0, 1)   
                    select 'true' as sucess, 'record added sucessfully' as msg   
                END   
        END     
SET NOCOUNT OFF;     
  
/*  
select * from tblhospitalActuals where   
brandId = 1    
                    and brandGroupId = 1 and skuId = 1 and ActualEnteredFor = '2022-11-01'  
*/
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_add_update_BUSINESS_TRACKERv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--    

/*   

    USP_add_update_BUSINESS_TRACKER   

    24, 31, 2, 2023, 7,9,25, 99, 1, 0, "27-12-2022"   

*/    

--------------------------------------------       

-- CREATED BY: GURU SINGH       

-- CREATED DATE: 24-SEP-2022       

--------------------------------------------       

CREATE PROCEDURE [BSV_IVF].[USP_add_update_BUSINESS_TRACKERv1]       

(   

    @empId int,   

    @hospitalId int,   

    @month int,   

    @year int,   

    @brandId int,   

    @brandGroupId int,   

    @skuId int,   

    @rate FLOAT,   

    @qty int,   

    @isContractApplicable bit  

)   

AS       

SET NOCOUNT on;      

        BEGIN     

            declare @actualEnteredFor smallDateTime    

            set  @actualEnteredFor = (DATEFROMPARTS (@Year, @Month, 1))    

            if exists (select  

             1 from tblhospitalActuals WHERE empId = @empId and brandId = @brandId    

                    and brandGroupId = @brandGroupId and skuId = @skuId and ActualEnteredFor = @actualEnteredFor)   

                BEGIN   

                    -- disable the record  

                    UPDATE tblhospitalActuals set   

                        isDisabled = 1  

                    WHERE empId = @empId and brandId = @brandId    

                    and brandGroupId = @brandGroupId and skuId = @skuId 

                    and ActualEnteredFor = @actualEnteredFor  AND hospitalId = @hospitalId

                    -- insert a new record, this way we'll keep a record of past entry  

                    INSERT into tblhospitalActuals (empId, hospitalId, ActualEnteredFor, brandId, brandGroupId, skuId,    

                    rate, qty, isContractApplicable, isDisabled, finalStatus)   

                    VALUES(@empId, @hospitalId, @actualEnteredFor, @brandId, @brandGroupId, @skuId,    

                    @rate, @qty, @isContractApplicable, 0, 1)   

                    select 'true' as sucess, 'record updated sucessfully' as msg   

                END   

            ELSE   

                BEGIN   

                    INSERT into tblhospitalActuals (empId, hospitalId, ActualEnteredFor, brandId, brandGroupId, skuId,    

                    rate, qty, isContractApplicable, isDisabled, finalStatus)   

                    VALUES(@empId, @hospitalId, @actualEnteredFor, @brandId, @brandGroupId, @skuId,    

                    @rate, @qty, @isContractApplicable, 0, 1)   

                    select 'true' as sucess, 'record added sucessfully' as msg   

                END   

        END     

SET NOCOUNT OFF;     

  

/*  

select * from tblhospitalActuals where   

brandId = 1    

                    and brandGroupId = 1 and skuId = 1 and ActualEnteredFor = '2022-11-01'  

*/
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ADD_UPDATE_CHAIN_ACCOUNT]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
USP_ADD_UPDATE_CHAIN_ACCOUNT null, 'ajay', 0
*/ 
------------------------------- 
-- CREATED BY: GURU SINGH 
-- CREATED DATE: 26-NOV-2022 
------------------------------- 
CREATE PROCEDURE [BSV_IVF].[USP_ADD_UPDATE_CHAIN_ACCOUNT]  
(
    @accountID INT = null,
    @name NVARCHAR(100),
    @isDisabled BIT

)
AS   
SET NOCOUNT ON;   
        
            IF @accountID is NULL 
                BEGIN
                    insert into tblChainAccountType (name, isDisabled)
                    VALUES (@name, @isDisabled)
                    select 'true' as sucess, 'record created successfully' as msg
                END
            ELSE
                BEGIN   
                    UPDATE tblChainAccountType
                        SET name = @name, 
                            isDisabled = @isDisabled
                    where accountid = @accountId
                    select 'true' as sucess, 'record updated successfully' as msg
                END
SET NOCOUNT OFF;   

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ADD_UPDATE_CUSTSOMER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
USP_ADD_UPDATE_CUSTSOMER  
    55, 'code', 'DoctorN1ame', 1, 1, '12345', 'mobile',  
                    'email', 'CENTRENAME', 'Address1', 'Address2', 'LocalArea', 'City',  
                    1, 'PinCode', 'ChemistMapped', 1, 1 , 1 , 3, '18-Dec-2022'
*/  
-------------------------------  
-- CREATED DATE: 26-NOV-2022  
-- CREATED BY: GURU SINGH  
-------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_ADD_UPDATE_CUSTSOMER]   
(    
  
    @customerId INT = NULL,  
    @code NVARCHAR(10),  
    @DoctorName NVARCHAR(100),  
    @visitId int,  
    @SpecialtyID int,  
    @DoctorUniqueCode NVARCHAR(100),  
    @mobile NVARCHAR(20),  
    @email NVARCHAR(20),  
    @CENTRENAME NVARCHAR(100),  
    @Address1 NVARCHAR(500),  
    @Address2 NVARCHAR(200),  
    @LocalArea NVARCHAR(200),  
    @City NVARCHAR(200),  
    @StateID INT,  
    @PinCode  NVARCHAR(20),  
    @ChemistMapped NVARCHAR(200),  
    @isDisabled bit,  
    @chainID int , 
    @chainAccountTypeId INT,
    @isRateContractApplicable smallInt,
    @contractEndDate smallDateTime

)    
AS    
SET NOCOUNT ON;    
        if (@customerId IS NULL)   
            BEGIN  
                declare @hospitalId int;
                -- INSERT  
                --select * from tblCustomers  
                INSERT INTO tblCustomers (  
                    code, DoctorName, visitId, SpecialtyID, DoctorUniqueCode, mobile,  
                    email, CENTRENAME, Address1, Address2, LocalArea, City,  
                    StateID, PinCode, ChemistMapped, isDisabled, chainID, chainAccountTypeId  
                    )  
                VALUES (@code, @DoctorName, @visitId, @SpecialtyID, @DoctorUniqueCode, @mobile,  
                    @email, @CENTRENAME, @Address1, @Address2, @LocalArea, @City,  
                    @StateID, @PinCode, @ChemistMapped, @isDisabled, @chainID, @chainAccountTypeId)  

                set @hospitalId = @@IDENTITY;

                if (@isRateContractApplicable = 0) 
                    BEGIN
                        insert into TblHospitalsContracts (hospitalId, contractEndDate, isContractSubmitted)
                        values (@hospitalId, @contractEndDate, 1)
                    END

                select 'true' as [sucess], 'USer added sucessfully' as msg  
            END  
        ELSE  
            BEGIN    
                -- UPDATE  
                    UPDATE tblCustomers SET  
                        code = @code,  
                        DoctorName = @DoctorName,  
                        visitId = @visitId,  
                        SpecialtyID = @SpecialtyID,  
                        DoctorUniqueCode = @DoctorUniqueCode,  
                        email = @email,  
                        mobile = @mobile,  
                        CENTRENAME = @CENTRENAME,  
                        Address1 = @Address1,  
                        Address2 = @Address2,  
                        LocalArea = @LocalArea,  
                        City = @City,  
                        StateID = @StateID,  
                        PinCode = @PinCode,  
                        ChemistMapped = @ChemistMapped,  
                        chainID = @chainID,  
                        isDisabled = @isDisabled , 
                        chainAccountTypeId = @chainAccountTypeId 
                    where customerId = @customerId  

                     if (@isRateContractApplicable = 5) 
                    BEGIN
                        if exists (select 1 from TblHospitalsContracts where hospitalId = @customerId)
                           BEGIN
                                UPDATE TblHospitalsContracts set 
                                        contractEndDate = @contractEndDate
                                where hospitalId = @customerId
                            END 
                        else
                            BEGIN
                                 insert into TblHospitalsContracts (hospitalId, contractEndDate, isContractSubmitted)
                                values (@customerId, @contractEndDate, 1)
                            END
                        
                    END
                    select 'true' as [sucess], 'USer updated sucessfully' as msg  
            END  
SET NOCOUNT OFF; 


/*
 select * from TblHospitalsContracts where hospitalId = 54
 */

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ADD_UPDATE_MARKET_INSIGHT_BY_KAM]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------    
-- CREATED BY: GURU SINGH    
-- CREATED DATE: 16-FEB-2023    
-------------------------------------------    
CREATE PROCEDURE [BSV_IVF].[USP_ADD_UPDATE_MARKET_INSIGHT_BY_KAM]    
(    
    @insightId INT = NULL,    
    @empId INT  = NULL,    
    @centreId INT  = NULL,    
    @month int  = NULL,       
    @year int   = NULL,     
    @answerOne BIT = NULL,    
    @AnswerTwo NVARCHAR(50) = NULL,    
    @answerThreeRFSH NVARCHAR(50) = NULL,    
    @answerThreeHMG NVARCHAR(50) = NULL,    
    @answerFourRHCG NVARCHAR(50) = NULL,    
    @answerFourAgonistL NVARCHAR(50) = NULL,    
    @answerFourAgonistT NVARCHAR(50) = NULL,    
    @answerFourRHCGTriptorelin NVARCHAR(50) = NULL,    
    @answerFourRHCGLeuprolide NVARCHAR(50) = NULL,    
    @answerProgesterone NVARCHAR(50) = NULL,    
    @answerFiveDydrogesterone NVARCHAR(50) = NULL,    
    @answerFiveCombination NVARCHAR(50) = NULL,  
    @answerFourUHCG    NVARCHAR(50) = NULL  
        
)    
AS    
    SET NOCOUNT ON;    
     declare @addedFor date      
     set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))  
     declare @newInsightID  int;

     if not exists (select 1 from tblMarketInsights where empid = @empId and centreId = @centreId and addedFor = @addedFor) 
        BEGIN
            set @newInsightID = null
        END
    ELSE
        BEGIN
            select  @newInsightID = insightId FROM tblMarketInsights where empid = @empId and centreId = @centreId and addedFor = @addedFor
        END

    if @newInsightID is null    
        begin    
            declare @newmarkingId int
            INSERT INTO tblMarketInsights (empId, centreId, addedFor,     
                    answerOne, AnswerTwo, answerThreeRFSH ,answerThreeHMG,    
                    answerFourRHCG, answerFourAgonistL, answerFourAgonistT ,answerFourRHCGTriptorelin, answerFourRHCGLeuprolide,    
                    answerProgesterone, answerFiveDydrogesterone, answerFiveCombination, answerFourUHCG, finalstatus, createddate)    
            VALUES (@empId, @centreId, @addedFor,     
                    @answerOne, @AnswerTwo, @answerThreeRFSH ,@answerThreeHMG,    
                    @answerFourRHCG, @answerFourAgonistL, @answerFourAgonistT, @answerFourRHCGTriptorelin, @answerFourRHCGLeuprolide,    
                    @answerProgesterone, @answerFiveDydrogesterone, @answerFiveCombination, @answerFourUHCG, 1, GETDATE())    
            set @newmarkingId = @@IDENTITY;
                if exists (select 1 from TblHospitalsPotentials where empid = @empId and hospitalId = @centreId and PotentialEnteredFor = @addedFor)
                    BEGIN
                            declare @infCycle int;
                            select @infCycle = IVFCycle from TblHospitalsPotentials  where empid = @empId and hospitalId = @centreId and PotentialEnteredFor = @addedFor
                            update tblMarketInsights set  AnswerTwo = @infCycle  where   insightId = @newmarkingId   
                            select * from tblMarketInsights
                    END
        end    
    else    
        begin    
            update tblMarketInsights set    
                    empId = empId,     
                    centreId = @centreId,     
                    answerOne = @answerOne,     
                    AnswerTwo = @AnswerTwo,     
                    answerThreeRFSH  = @answerThreeRFSH,    
                    answerThreeHMG = @answerThreeHMG,    
                    answerFourRHCG = @answerFourRHCG,     
                    answerFourAgonistL = @answerFourAgonistL,     
                    answerFourAgonistT  = @answerFourAgonistT,    
                    answerFourRHCGTriptorelin = @answerFourRHCGTriptorelin,     
                    answerFourRHCGLeuprolide = @answerFourRHCGLeuprolide,    
                    answerProgesterone = @answerProgesterone,     
                    answerFiveDydrogesterone = @answerFiveDydrogesterone,     
                    answerFiveCombination = @answerFiveCombination,   
                    answerFourUHCG = @answerFourUHCG,  
                    isApproved = 1, 
                    finalstatus = 1 
            where insightId = @newInsightID    
        end     
            
    SET NOCOUNT OFF; 

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ADD_UPDATE_MARKET_INSIGHT_BY_KAMv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------    

-- CREATED BY: GURU SINGH    

-- CREATED DATE: 16-FEB-2023    

-------------------------------------------    

CREATE PROCEDURE [BSV_IVF].[USP_ADD_UPDATE_MARKET_INSIGHT_BY_KAMv1]    

(    

    @insightId INT = NULL,    

    @empId INT  = NULL,    

    @centreId INT  = NULL,    

    @month int  = NULL,       

    @year int   = NULL,     

    @answerOne BIT = NULL,    

    @AnswerTwo NVARCHAR(50) = NULL,    

    @answerThreeRFSH NVARCHAR(50) = NULL,    

    @answerThreeHMG NVARCHAR(50) = NULL,    

    @answerFourRHCG NVARCHAR(50) = NULL,    

    @answerFourAgonistL NVARCHAR(50) = NULL,    

    @answerFourAgonistT NVARCHAR(50) = NULL,    

    @answerFourRHCGTriptorelin NVARCHAR(50) = NULL,    

    @answerFourRHCGLeuprolide NVARCHAR(50) = NULL,    

    @answerProgesterone NVARCHAR(50) = NULL,    

    @answerFiveDydrogesterone NVARCHAR(50) = NULL,    

    @answerFiveCombination NVARCHAR(50) = NULL,  

    @answerFourUHCG    NVARCHAR(50) = NULL  

        

)    

AS    

    SET NOCOUNT ON;    

     declare @addedFor date      

     set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))  

     declare @newInsightID  int;



     if not exists (select 1 from tblMarketInsights where empid = @empId and centreId = @centreId and addedFor = @addedFor) 

        BEGIN

            set @newInsightID = null

        END

    ELSE

        BEGIN

            select  @newInsightID = insightId FROM tblMarketInsights where empid = @empId and centreId = @centreId and addedFor = @addedFor

        END



    if @newInsightID is null    

        begin    

            declare @newmarkingId int

            INSERT INTO tblMarketInsights (empId, centreId, addedFor,     

                    answerOne, AnswerTwo, answerThreeRFSH ,answerThreeHMG,    

                    answerFourRHCG, answerFourAgonistL, answerFourAgonistT ,answerFourRHCGTriptorelin, answerFourRHCGLeuprolide,    

                    answerProgesterone, answerFiveDydrogesterone, answerFiveCombination, answerFourUHCG, finalstatus, createddate)    

            VALUES (@empId, @centreId, @addedFor,     

                    @answerOne, @AnswerTwo, @answerThreeRFSH ,@answerThreeHMG,    

                    @answerFourRHCG, @answerFourAgonistL, @answerFourAgonistT, @answerFourRHCGTriptorelin, @answerFourRHCGLeuprolide,    

                    @answerProgesterone, @answerFiveDydrogesterone, @answerFiveCombination, @answerFourUHCG, 1, GETDATE())    

            set @newmarkingId = @@IDENTITY;

                if exists (select 1 from TblHospitalsPotentials where empid = @empId and hospitalId = @centreId and PotentialEnteredFor = @addedFor)

                    BEGIN

                            declare @infCycle int;

                            select @infCycle = IVFCycle from TblHospitalsPotentials  where empid = @empId and hospitalId = @centreId and PotentialEnteredFor = @addedFor

                            update tblMarketInsights set  AnswerTwo = @infCycle  where   insightId = @newmarkingId   

                            select * from tblMarketInsights

                    END

        end    

    else    

        begin    

            update tblMarketInsights set    

                    empId = empId,     

                    centreId = @centreId,     

                    answerOne = @answerOne,     

                    AnswerTwo = @AnswerTwo,     

                    answerThreeRFSH  = @answerThreeRFSH,    

                    answerThreeHMG = @answerThreeHMG,    

                    answerFourRHCG = @answerFourRHCG,     

                    answerFourAgonistL = @answerFourAgonistL,     

                    answerFourAgonistT  = @answerFourAgonistT,    

                    answerFourRHCGTriptorelin = @answerFourRHCGTriptorelin,     

                    answerFourRHCGLeuprolide = @answerFourRHCGLeuprolide,    

                    answerProgesterone = @answerProgesterone,     

   answerFiveDydrogesterone = @answerFiveDydrogesterone,     

                    answerFiveCombination = @answerFiveCombination,   

                    answerFourUHCG = @answerFourUHCG,  

                    isApproved = 1, 

                    finalstatus = 1 

            where insightId = @newInsightID    

        end     

            

    SET NOCOUNT OFF; 

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ADD_UPDATE_SKU_COMPETITION]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [BSV_IVF].[USP_ADD_UPDATE_SKU_COMPETITION] (    
    @empId int,    
    @centerId int,    
    @brandId int,    
    @skuId int,    
    @month int,     
    @year int ,   
    @value float,  
    @comments ntext = null  
)    
AS    
    BEGIN    
        declare @competitionAddedFor smallDateTime    
        set  @competitionAddedFor = (DATEFROMPARTS (@Year, @Month, 1))    
        if Exists (    
                select 1 from tblCompetitions    
                where     
                centerId = @centerId AND    
                brandId = @brandId AND    
                competitionSkuId = @skuId and competitionAddedFor = @competitionAddedFor   
        )    
            BEGIN    
                UPDATE tblCompetitions    
                set     
                    businessValue = @value,  
                    comments = @comments, 
                    isApproved = 1,
                    status = 1
                where     
                    centerId = @centerId AND    
                    brandId = @brandId AND    
                    competitionSkuId = @skuId and competitionAddedFor = @competitionAddedFor   
   
                select 'true' as success, 'record updated successfully' as msg    
            END    
        else    
            BEGIN    
                INSERT into tblCompetitions (empId, centerId, brandId,     
                CompetitionSkuId, competitionAddedFor,     
                businessValue, comments, status)    
                VALUES (    
                    @empId, @centerId, @brandId,    
                    @skuId, @competitionAddedFor,    
                    @value, @comments, 1    
                )    
                select 'true' as success, 'record inserted successfully' as msg    
            END    
                
                
    END   
   
   
   -- alter table tblCompetitions add businessValue FLOAT 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ADD_UPDATE_SKU_COMPETITIONv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [BSV_IVF].[USP_ADD_UPDATE_SKU_COMPETITIONv1] (    

    @empId int,    

    @centerId int,    

    @brandId int,    

    @skuId int,    

    @month int,     

    @year int ,   

    @value float,  

    @comments ntext = null  

)    

AS    

    BEGIN    

        declare @competitionAddedFor smallDateTime    

        set  @competitionAddedFor = (DATEFROMPARTS (@Year, @Month, 1))    

        if Exists (    

                select 1 from tblCompetitions    

                where     

                centerId = @centerId AND    

                brandId = @brandId AND    

                competitionSkuId = @skuId and competitionAddedFor = @competitionAddedFor   

        )    

            BEGIN    

                UPDATE tblCompetitions    

                set     

                    businessValue = @value,  

                    comments = @comments, 

                    isApproved = 1,

                    status = 1

                where     

                    centerId = @centerId AND    

                    brandId = @brandId AND    

                    competitionSkuId = @skuId and competitionAddedFor = @competitionAddedFor   

   

                select 'true' as success, 'record updated successfully' as msg    

            END    

        else    

            BEGIN    

                INSERT into tblCompetitions (empId, centerId, brandId,     

                CompetitionSkuId, competitionAddedFor,     

                businessValue, comments, status)    

                VALUES (    

                    @empId, @centerId, @brandId,    

                    @skuId, @competitionAddedFor,    

                    @value, @comments, 1    

                )    

                select 'true' as success, 'record inserted successfully' as msg    

            END    

                

                

    END   

   

   

   -- alter table tblCompetitions add businessValue FLOAT 
GO
/****** Object:  StoredProcedure [BSV_IVF].[usp_all_CCM_report]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- last record 4877 
create procedure [BSV_IVF].[usp_all_CCM_report] 
as 
BEGIN

    SELECT 
-- top 10 
 -- count(*)
 [BSV_IVF].[getMyZBMInfo](e.EmpID) as zBM,
[BSV_IVF].[getMyRBMInfo](e.EmpID) as RBM,
e.EmpID, 
e.firstname, 
e.Designation

--top 100 1
,c.customerId
,DoctorName, c.mobile, c.email,    CENTRENAME, Address1, Address2, localarea, 
city, 
S.StateName, 
PinCode, DoctorUniqueCode
,ST.name as Specialty, VT.NAME as visitType, A.accountName
 from tblcustomers C
INNER JOIN tblState S ON S.STATEID = C.StateID -- 8368 
INNER JOIN tblSpecialtyType ST ON ST.specialtyId = C.SpecialtyId -- 8352
INNER JOIN tblVisitType VT ON VT.VISITiD = C.visitId -- 8352
left OUTER JOIN tblAccount A ON A.ACCOUNTID = C.accountID -- 5239
inner join tblEmpHospitals eh on eh.hospitalId = c.customerId -- 5747
inner join tblEmployees e on e.empId = eh.empId and e.isDisabled = 0 -- 5627
where customerId > 30 and c.isdisabled = 0



END

-- select * from tblEmployees where designation = 'zbm'
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_BUSINESS_TRACKER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_BUSINESS_TRACKER_DETAILS 38, 11, 2022 
  -------------------------------        
   -- CREATED BY: GURU SINGH        
   -- CREATED DATE: 26-NOV-2022        
   -------------------------------        
   CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_BUSINESS_TRACKER]    
   (  
       @customerId int, 
       @month int, 
       @year int, 
       @rbmId int  
   )            
    AS            
        SET NOCOUNT ON;                    
            BEGIN                      
                declare @actualEnteredFor smallDateTime  
                -- set  @actualEnteredFor = (DATEFROMPARTS (@Year, @Month, 1))  
                set  @actualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)  
                 
                update tblhospitalActuals  
                    set isApproved = 0, 
                        approvedBy = @rbmId, 
                        approvedOn = GETDATE() 
                where hospitalId = @customerId  
                and ActualEnteredFor = @actualEnteredFor and isDisabled = 0   
                select 'true' as success, 'record approved sucessfully' as msg        
            END          
        SET NOCOUNT OFF; 

        -- select DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)  

        -- select * from tblhospitalActuals  
        --         where ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0) and isDisabled = 0  
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_BUSINESS_TRACKER_BY_HOSPITALID]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_RBM_BUSINESS_LIST_FOR_APPROVAL 24     
--------------------------------------------          
-- CREATED BY: GURU SINGH          
-- CREATED DATE: 24-SEP-2022          
--------------------------------------------          
CREATE  PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_BUSINESS_TRACKER_BY_HOSPITALID]          
(      
    @customerId int,     
    @rbmId int,    
    @mode smallInt,    
    @rejectReason NVARCHAR(1000)       
)      
AS          
SET NOCOUNT on;         
        BEGIN       
        declare @desination NVARCHAR(3)  
        select top 1 @desination  = Designation from tblemployees where empID = @rbmId  
        if UPPER(@desination) = 'RBM'  
            BEGIN  
                update tblhospitalActuals     
                    set isApproved = @mode,     
                        approvedBy = @rbmId,     
                        approvedOn = GETDATE(),  
                        ZBMApproved = 1      
                    where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)      
                    -- where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)      
                    if (@mode = 2)    
                    BEGIN    
                        update tblhospitalActuals                  
                            set rejectedBy = @rbmId,                      
                                rejectedOn = GETDATE(),    
                                rejectComments = @rejectReason,    
                                approvedBy = NULL,                     
                                approvedOn = NULL,  
                                ZBMApproved = null,  
                                finalSTATUS = 2                          
                        where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)      
                        -- where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)      
                    END     
            END  
        ELSE  
            BEGIN  
                update tblhospitalActuals     
                    set isApproved = @mode,     
                        approvedBy = @rbmId,     
                        approvedOn = GETDATE(),  
                        ZBMApproved = @mode,  
                        finalSTATUS = 0       
                    where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)      
                    -- where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)      
                    if (@mode = 2)    
                    BEGIN    
                        update tblhospitalActuals                  
                            set rejectedBy = @rbmId,                      
                                rejectedOn = GETDATE(),    
                                rejectComments = @rejectReason,    
                                approvedBy = NULL,                     
                                approvedOn = NULL,  
                                finalSTATUS = 2                         
                        where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)      
                        -- where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)      
                    END     
            END  
        END     
SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_BUSINESS_TRACKER_BY_HOSPITALIDv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_RBM_BUSINESS_LIST_FOR_APPROVAL 24     



--------------------------------------------          



-- CREATED BY: GURU SINGH          



-- CREATED DATE: 24-SEP-2022          



--------------------------------------------          



CREATE  PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_BUSINESS_TRACKER_BY_HOSPITALIDv1]          



(      



    @customerId int,     



    @rbmId int,    



    @mode smallInt,    



    @rejectReason NVARCHAR(1000)       



)      



AS          



SET NOCOUNT on;         



        BEGIN       



        declare @desination NVARCHAR(3)  



        select top 1 @desination  = Designation from tblemployees where empID = @rbmId  



        if UPPER(@desination) = 'RBM'  



            BEGIN  



                update tblhospitalActuals     



                    set isApproved = @mode,     



                        approvedBy = @rbmId,     



                        approvedOn = GETDATE(),  



                        ZBMApproved = 1      



                    --where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)      --for feb



                    where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)  --for jan     



                    if (@mode = 2)    



                    BEGIN    



                        update tblhospitalActuals                  



                            set rejectedBy = @rbmId,                      



                                rejectedOn = GETDATE(),    



                                rejectComments = @rejectReason,    



                                approvedBy = NULL,                     



                                approvedOn = NULL,  



                                ZBMApproved = null,  



                                finalSTATUS = 2                          



                        --where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)      --for feb  



                         where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)   --for jan   



                    END     



            END  



        ELSE  



            BEGIN  



                update tblhospitalActuals     



                    set isApproved = @mode,     



                        approvedBy = @rbmId,     



                        approvedOn = GETDATE(),  



                        ZBMApproved = @mode,  



                        finalSTATUS = 0       



                   -- where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)    --for feb  



                    where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)  --for jan    



                    if (@mode = 2)    



                    BEGIN    



                        update tblhospitalActuals                  



                            set rejectedBy = @rbmId,                      



                                rejectedOn = GETDATE(),    



                                rejectComments = @rejectReason,    



                                approvedBy = NULL,                     



                                approvedOn = NULL,  



                                finalSTATUS = 2                         



                        --where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)    --for feb  



                        where hospitalId = @customerId and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)    -- for jan  



                    END     



            END  



        END     



SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_COMPETITION]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_APPROVE_CUSTOMER_COMPETITION 61, 12, 2022, 52    
 ------------------------------------------------   
 -- CREATED BY: GURU SINGH   
 -- CREATED DATE: 13-DEC-2022   
 ------------------------------------------------   
 CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_COMPETITION]   
 (    
    @hospitalId int,        
    @month int,    
    @year int ,    
    @rbmId Int, 
    @mode smallInt, 
    @rejectReason NVARCHAR(1000)        
) AS       
    SET NOCOUNT ON;           
        DECLARE @competitionId int     
         declare @competitionAddedFor smallDateTime   
            set  @competitionAddedFor = (DATEFROMPARTS (@year, @month, 1))   

                -- check if its rbmId is belong to rbm or zbm
                -- if rbm then execute the exisiting logic
                -- if zbm then update zbm related fields
            declare @desination NVARCHAR(3)
            select top 1 @desination  = Designation from tblemployees where empID = @rbmId
            if UPPER(@desination) = 'RBM'
                BEGIN
                    update tblCompetitions               
                        set 
                        isApproved = @mode,                   
                        approvedBy = @rbmId,                   
                        approvedOn = GETDATE(),
                        isZBMApproved = 1 
                    where centerId = @hospitalId and competitionAddedFor =  @competitionAddedFor 
                    if (@mode = 2) 
                    BEGIN 
                        update tblCompetitions               
                            set rejectedBy = @rbmId,                   
                                rejectedOn = GETDATE(), 
                                rejectComments = @rejectReason,  
                                approvedBy = NULL,                   
                                approvedOn = NULL,
                                isZBMApproved = null,
                                STATUS = 2  
                        where centerId = @hospitalId and competitionAddedFor =  @competitionAddedFor  
                    END      
                END
            ELSE  -- ZBM
                BEGIN
                    update tblCompetitions               
                        set 
                        ZBMId = @rbmId,                   
                        ZBMApprovedOn = GETDATE(),
                        isZBMApproved = @mode,
                        isApproved = @mode,
                         STATUS = 0  
                    where centerId = @hospitalId and competitionAddedFor =  @competitionAddedFor
                    if (@mode = 2) 
                    BEGIN 
                        update tblCompetitions               
                            set rejectedBy = @rbmId,                   
                                rejectedOn = GETDATE(), 
                                rejectComments = @rejectReason,  
                                approvedBy = NULL,                   
                                approvedOn = NULL,
                                STATUS = 2 
                        where centerId = @hospitalId and competitionAddedFor =  @competitionAddedFor  
                    END     
                END

                       
                select 'true' as success, 'record approved sucessfully' as msg        
        SET NOCOUNT OFF;  

 -- SELECT TOP 1 * FROM tblCompetitions
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_COMPETITIONv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_APPROVE_CUSTOMER_COMPETITION 61, 12, 2022, 52    

 ------------------------------------------------   

 -- CREATED BY: GURU SINGH   

 -- CREATED DATE: 13-DEC-2022   

 ------------------------------------------------   

 CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_COMPETITIONv1]   

 (    

    @hospitalId int,        

    @month int,    

    @year int ,    

    @rbmId Int, 

    @mode smallInt, 

    @rejectReason NVARCHAR(1000)        

) AS       

    SET NOCOUNT ON;           

        DECLARE @competitionId int     

         declare @competitionAddedFor smallDateTime   

            set  @competitionAddedFor = (DATEFROMPARTS (@year, @month, 1))   



                -- check if its rbmId is belong to rbm or zbm

                -- if rbm then execute the exisiting logic

                -- if zbm then update zbm related fields

            declare @desination NVARCHAR(3)

            select top 1 @desination  = Designation from tblemployees where empID = @rbmId

            if UPPER(@desination) = 'RBM'

                BEGIN

                    update tblCompetitions               

                        set 

                        isApproved = @mode,                   

                        approvedBy = @rbmId,                   

                        approvedOn = GETDATE(),

                        isZBMApproved = 1 

                    where centerId = @hospitalId and competitionAddedFor =  @competitionAddedFor 

                    if (@mode = 2) 

                    BEGIN 

                        update tblCompetitions               

                            set rejectedBy = @rbmId,                   

                                rejectedOn = GETDATE(), 

                                rejectComments = @rejectReason,  

                                approvedBy = NULL,                   

                                approvedOn = NULL,

                                isZBMApproved = null,

                                STATUS = 2  

                        where centerId = @hospitalId and competitionAddedFor =  @competitionAddedFor  

                    END      

                END

            ELSE  -- ZBM

                BEGIN

                    update tblCompetitions               

                        set 

                        ZBMId = @rbmId,                   

                        ZBMApprovedOn = GETDATE(),

                        isZBMApproved = @mode,

                        isApproved = @mode,

                         STATUS = 0  

                    where centerId = @hospitalId and competitionAddedFor =  @competitionAddedFor

                    if (@mode = 2) 

                    BEGIN 

                        update tblCompetitions               

                            set rejectedBy = @rbmId,                   

                                rejectedOn = GETDATE(), 

                                rejectComments = @rejectReason,  

                                approvedBy = NULL,                   

                                approvedOn = NULL,

                                STATUS = 2 

                        where centerId = @hospitalId and competitionAddedFor =  @competitionAddedFor  

                    END     

                END



                       

                select 'true' as success, 'record approved sucessfully' as msg        

        SET NOCOUNT OFF;  



 -- SELECT TOP 1 * FROM tblCompetitions
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_MARKET_INSIGHT_BY_RBM]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------
-- CREATED BY: GURU SINGH
-- CREATED DATE: 16-FEB-2023
-------------------------------------------
CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_MARKET_INSIGHT_BY_RBM]
(
    @insightId int,
    @rbmId Int,
    @mode smallInt,
    @rejectReason NVARCHAR(1000)  
    
)
AS
    SET NOCOUNT ON;
     declare @desination NVARCHAR(3)
     select top 1 @desination  = Designation from tblemployees where empID = @rbmId
     if UPPER(@desination) = 'RBM'
        BEGIN
            update tblMarketInsights
                set isApproved = @mode,
                    ApprovedBy = @rbmId,
                    ApprovedOn = GETDATE(),
                    rejectComments = null,
                    ZBMApproved = 1 
            where insightId = @insightId
            if (@mode = 2)
            BEGIN
                update tblMarketInsights              
                    set rejectedBy = @rbmId,                  
                        rejectedOn = GETDATE(),
                        rejectComments = @rejectReason,
                        ApprovedBy = null,
                        ApprovedOn = null,
                        ZBMApproved = null,
                        finalSTATUS = 2  
                where insightId = @insightId
            END   
        END
    ELSE
        BEGIN
            update tblMarketInsights
                set 
                    ZBMId = @rbmId,                   
                    ZBMApprovedOn = GETDATE(),
                    ZBMApproved = @mode,
                    isApproved = @mode,
                    rejectComments = null,
                    finalSTATUS = 0  
            where insightId = @insightId
            if (@mode = 2)
            BEGIN
                update tblMarketInsights              
                    set rejectedBy = @rbmId,                   
                        rejectedOn = GETDATE(), 
                        rejectComments = @rejectReason,  
                        approvedBy = NULL,                   
                        approvedOn = NULL,
                       finalSTATUS = 2 
                where insightId = @insightId
            END
        END
        select 'true' as success, 'record updated sucessfully' as msg 
    SET NOCOUNT OFF;


    

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_MARKET_INSIGHT_BY_RBMv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------

-- CREATED BY: GURU SINGH

-- CREATED DATE: 16-FEB-2023

-------------------------------------------

CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_MARKET_INSIGHT_BY_RBMv1]

(

    @insightId int,

    @rbmId Int,

    @mode smallInt,

    @rejectReason NVARCHAR(1000)  

    

)

AS

    SET NOCOUNT ON;

     declare @desination NVARCHAR(3)

     select top 1 @desination  = Designation from tblemployees where empID = @rbmId

     if UPPER(@desination) = 'RBM'

        BEGIN

            update tblMarketInsights

                set isApproved = @mode,

                    ApprovedBy = @rbmId,

                    ApprovedOn = GETDATE(),

                    rejectComments = null,

                    ZBMApproved = 1 

            where insightId = @insightId

            if (@mode = 2)

            BEGIN

                update tblMarketInsights              

                    set rejectedBy = @rbmId,                  

                        rejectedOn = GETDATE(),

                        rejectComments = @rejectReason,

                        ApprovedBy = null,

                        ApprovedOn = null,

                        ZBMApproved = null,

                        finalSTATUS = 2  

                where insightId = @insightId

            END   

        END

    ELSE

        BEGIN

            update tblMarketInsights

                set 

                    ZBMId = @rbmId,                   

                    ZBMApprovedOn = GETDATE(),

                    ZBMApproved = @mode,

                    isApproved = @mode,

                    rejectComments = null,

                    finalSTATUS = 0  

            where insightId = @insightId

            if (@mode = 2)

            BEGIN

                update tblMarketInsights              

                    set rejectedBy = @rbmId,                   

                        rejectedOn = GETDATE(), 

                        rejectComments = @rejectReason,  

                        approvedBy = NULL,                   

                        approvedOn = NULL,

                       finalSTATUS = 2 

                where insightId = @insightId

            END

        END

        select 'true' as success, 'record updated sucessfully' as msg 

    SET NOCOUNT OFF;





    

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_MasterData]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_APPROVE_CUSTOMER_POTENTIALS 24, 31, 24 
------------------------------------------------
-- CREATED BY: GURU SINGH
-- CREATED DATE: 13-DEC-2022
------------------------------------------------
CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_MasterData]
(
    @customerId int,
    @rbmId Int
    
)
AS
    SET NOCOUNT ON;
         UPDATE tblCustomers
            SET isApproved = 0,
                approvedBy = @rbmId,
                approvedOn = GETDATE()
        WHERE customerId = @customerId
        select 'true' as success, 'record approved sucessfully' as msg 
    SET NOCOUNT OFF;
    

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_POTENTIALS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- USP_APPROVE_CUSTOMER_POTENTIALS 24, 31, 24 
------------------------------------------------
-- CREATED BY: GURU SINGH
-- CREATED DATE: 13-DEC-2022
------------------------------------------------
CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_POTENTIALS]
(
    @kamId int,  
    @hospitalId int ,
    @rbmId Int
    
)
AS
    SET NOCOUNT ON;
        DECLARE @potentialId int
         SELECT top 1 @potentialId = potentialID FROM TblHospitalsPotentials WHERE empId = @kamId and hospitalId = @hospitalId  
            order by potentialId desc  
        update TblHospitalsPotentials
            set isApproved = 0,
                approvedBy = @rbmId,
                approvedOn = GETDATE()
        where potentialID = @potentialId
        select 'true' as success, 'record approved sucessfully' as msg 
    SET NOCOUNT OFF;
    

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_POTENTIALS_BY_POTENTIALID]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_APPROVE_CUSTOMER_POTENTIALS 24, 31, 24     
 ------------------------------------------------    
 -- CREATED BY: GURU SINGH    
 -- CREATED DATE: 13-DEC-2022    
 ------------------------------------------------    
 CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_POTENTIALS_BY_POTENTIALID]    
 (       
    @potentialId int,        
    @rbmId Int,  
    @mode smallInt,  
    @rejectReason NVARCHAR(1000)           
)    
AS        
    SET NOCOUNT ON;            
        declare @desination NVARCHAR(3) 
        select top 1 @desination  = Designation from tblemployees where empID = @rbmId 
        if UPPER(@desination) = 'RBM' 
            BEGIN 
                UPDATE TblHospitalsPotentials                
                    set isApproved = @mode,                    
                    approvedBy = @rbmId,                    
                    approvedOn = GETDATE(), 
                    rejectComments = null,   
                    ZBMApproved = 1             
                where potentialID = @potentialId    
                if (@mode = 2)  
                BEGIN  
                    update TblHospitalsPotentials                
                        set rejectedBy = @rbmId,                    
                            rejectedOn = GETDATE(),  
                            rejectComments = @rejectReason,   
                            approvedBy = NULL,                    
                            approvedOn = NULL , 
                            ZBMApproved = null, 
                            finalSTATUS = 2             
                    where potentialID = @potentialId    
                END    
            END  
        ELSE 
            BEGIN 
                UPDATE TblHospitalsPotentials                
                set  
                -- isApproved = @mode,                    
                -- approvedBy = @rbmId,                    
                -- approvedOn = GETDATE()            
                    ZBMId = @rbmId,                    
                    ZBMApprovedOn = GETDATE(), 
                    rejectComments = null,   
                    ZBMApproved = @mode, 
                    isApproved = @mode, 
                    finalSTATUS = 0 
            where potentialID = @potentialId    
            if (@mode = 2)  
            BEGIN  
                update TblHospitalsPotentials                
                    set rejectedBy = @rbmId,                    
                        rejectedOn = GETDATE(),  
                        rejectComments = @rejectReason,   
                        approvedBy = NULL,                    
                        approvedOn = NULL, 
                       finalSTATUS = 2             
                where potentialID = @potentialId    
            END    
            END 
 
                 
        select 'true' as success, 'record approved sucessfully' as msg         
    SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_POTENTIALS_BY_POTENTIALIDv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_APPROVE_CUSTOMER_POTENTIALS 24, 31, 24     

 ------------------------------------------------    

 -- CREATED BY: GURU SINGH    

 -- CREATED DATE: 13-DEC-2022    

 ------------------------------------------------    

 CREATE PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_POTENTIALS_BY_POTENTIALIDv1]    

 (       

    @potentialId int,        

    @rbmId Int,  

    @mode smallInt,  

    @rejectReason NVARCHAR(1000)           

)    

AS        

    SET NOCOUNT ON;            

        declare @desination NVARCHAR(3) 

        select top 1 @desination  = Designation from tblemployees where empID = @rbmId 

        if UPPER(@desination) = 'RBM' 

            BEGIN 

                UPDATE TblHospitalsPotentials                

                    set isApproved = @mode,                    

                    approvedBy = @rbmId,                    

                    approvedOn = GETDATE(), 

                    rejectComments = null,   

                    ZBMApproved = 1             

                where potentialID = @potentialId    

                if (@mode = 2)  

                BEGIN  

                    update TblHospitalsPotentials                

                        set rejectedBy = @rbmId,                    

                            rejectedOn = GETDATE(),  

                            rejectComments = @rejectReason,   

                            approvedBy = NULL,                    

                            approvedOn = NULL , 

                            ZBMApproved = null, 

                            finalSTATUS = 2             

                    where potentialID = @potentialId    

                END    

            END  

        ELSE 

            BEGIN 

                UPDATE TblHospitalsPotentials                

                set  

                -- isApproved = @mode,                    

                -- approvedBy = @rbmId,                    

                -- approvedOn = GETDATE()            

                    ZBMId = @rbmId,                    

                    ZBMApprovedOn = GETDATE(), 

                    rejectComments = null,   

                    ZBMApproved = @mode, 

                    isApproved = @mode, 

                    finalSTATUS = 0 

            where potentialID = @potentialId    

            if (@mode = 2)  

            BEGIN  

                update TblHospitalsPotentials                

                    set rejectedBy = @rbmId,                    

                        rejectedOn = GETDATE(),  

                        rejectComments = @rejectReason,   

                        approvedBy = NULL,                    

                        approvedOn = NULL, 

                       finalSTATUS = 2             

                where potentialID = @potentialId    

            END    

            END 

 

                 

        select 'true' as success, 'record approved sucessfully' as msg         

    SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_APPROVE_CUSTOMER_RATE_CONTRACT_BY_CATID]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_APPROVE_CUSTOMER_RATE_CONTRACT_BY_CATID 24 
--------------------------------------------      
-- CREATED BY: GURU SINGH      
-- CREATED DATE: 24-SEP-2022      
--------------------------------------------      
CREATE  PROCEDURE [BSV_IVF].[USP_APPROVE_CUSTOMER_RATE_CONTRACT_BY_CATID]      
(  
    @CATID int, 
    @ZbmId int 
)  
AS      
SET NOCOUNT on;     
        BEGIN   
        update tblChainAccountType 
        set isApproved = 0, 
            approvedBy = @ZbmId, 
            approvedOn = GETDATE() 
        where ACCOUNTID = @CATID 
        declare @CustomerAccountId int
        select @CustomerAccountId = customerAccountID from tblChainAccountType where accountID = @CATID
        --select * from tblCustomers where accountID = 1025
        update tblCustomers set chainAccountTypeId = @CATID where accountID = @CustomerAccountId
 
        END 
SET NOCOUNT OFF; 

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSV_ADD_UPDATE_SKU]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------  
-- CREATED BY: GURU SINGH  
-- CREATED DATE: 24-SEP-2022  
--------------------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_BSV_ADD_UPDATE_SKU]  
(
    @medID int = null,
    @brandId int,
    @brandGroupId int, 
    @medicineName nvarchar(200),
    @isDisabled bit,
    @Price FLOAT
)
AS  
SET NOCOUNT on; 
    if (@medID is null) 
        BEGIN
            insert into tblSkus (brandId, brandGroupId, medicineName, isDisabled, Price)
            values (@brandId, @brandGroupId, @medicineName, @isDisabled, @Price)
            select 'true' as sucess, 'SKU created sucessfully' as msg
        END
    ELSE
        BEGIN
            update tblSkus SET
                brandId = @brandId,
                brandGroupId = @brandGroupId,
                medicineName = @medicineName,
                isDisabled =  @isDisabled,
                Price = @Price
            where medID = @medID
            select 'true' as sucess, 'SKU updated sucessfully' as msg
        END
SET NOCOUNT OFF;  
  

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSV_GET_MASTER_DATA]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
   
--------------------------------------------   
-- CREATED BY: GURU SINGH   
-- CREATED DATE: 24-SEP-2022   
--------------------------------------------   
CREATE PROCEDURE [BSV_IVF].[USP_BSV_GET_MASTER_DATA]   
AS   
SET NOCOUNT on;  
    SELECT stateId, stateName FROM tblState  WHERE isDisabled = 0 ORDER BY statename ASC   
    SELECT chainId, Name FROM tblChainStatus  WHERE isDisabled = 0 ORDER BY Name ASC   
    SELECT VisitID, Name FROM tblVisitType  WHERE isDisabled = 0 ORDER BY Name ASC   
    SELECT SpecialtyID, Name FROM tblSpecialtyType  WHERE isDisabled = 0 ORDER BY Name ASC   
    SELECT accountId, Name  FROM tblChainAccountType WHERE isDisabled = 0 ORDER BY Name ASC   
SET NOCOUNT OFF;   
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSV_GET_PERSON_ADD]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BSV_IVF].[USP_BSV_GET_PERSON_ADD] 
@Id int,
@FirstName nvarchar(255),
@LastName nvarchar(255),
@Age int
AS
	INSERT INTO Persons (Id, FirstName, LastName, Age)
	VALUES (@Id, @FirstName, @LastName, @Age)

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSV_GET_PERSON_LIST]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BSV_IVF].[USP_BSV_GET_PERSON_LIST]
AS
 select * from Persons
GO;
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSV_GET_SKU_LIST]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------  
-- CREATED BY: GURU SINGH  
-- CREATED DATE: 24-SEP-2022  
--------------------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_BSV_GET_SKU_LIST]  
AS  
SET NOCOUNT on; 
        BEGIN
           SELECT medID as SkuId, S.brandId, sg.brandName, S.brandGroupId, bg.groupName,  medicineName, price FROM tblSKUs S 
           INNER JOIN tblSkuGroup SG ON sg.brandId = s.brandId
           INNER JOIN tblBrandGroups BG ON s.brandGroupId = bg.brandGroupId
           where s.isDisabled = 0
        END
SET NOCOUNT OFF;  
  

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSV_GET_SKU_MASTER_DATA]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------  
-- CREATED BY: GURU SINGH  
-- CREATED DATE: 24-SEP-2022  
--------------------------------------------  
create PROCEDURE [BSV_IVF].[USP_BSV_GET_SKU_MASTER_DATA]  
AS  
SET NOCOUNT on; 
    SELECT brandId, brandName FROM tblSkuGroup  WHERE isDisabled = 0 ORDER BY sortOrder ASC  
    SELECT brandGroupID, brandId, groupName FROM tblBrandGroups where isDisabled = 0 order by brandGroupId ASC
SET NOCOUNT OFF;  
  

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSVIVF_GET_POTENTIALS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------  
 -- CREATED BY: GURU SINGH  
 -- CREATED DATE: 24-SEP-2022  
 --------------------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_BSVIVF_GET_POTENTIALS]
(  
    @hospitalId int = null,  
    @empId INT = NULL,
    @startDate smallDateTime = null,
    @endDate smallDateTime = null 
)  
AS  
SET NOCOUNT ON;  
   -- SELECT sum(CAST(IUICycle AS INT)) as IUICycle, sum(CAST(IVFCycle AS INT)) as IVFCycle FROM tblhospitalsPotentials 
    SELECT  * FROM tblhospitalsPotentials 
SET NOCOUNT OFF;  

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSVIVF_REPORT_GET_BUSINESS_TRACKER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
--------------------------------------------   
 -- CREATED BY: GURU SINGH   
 -- CREATED DATE: 24-SEP-2022   
 --------------------------------------------   
 -- exec USP_BSVIVF_REPORT_GET_RCAgreement null, 999, null, null 
CREATE PROCEDURE [BSV_IVF].[USP_BSVIVF_REPORT_GET_BUSINESS_TRACKER]  
(   
    @hospitalId int = null,   
    @empId INT = null, 
    @startDate smallDateTime = null, 
    @endDate smallDateTime = null  
)   
AS   
SET NOCOUNT ON;   
 
select isNull(sum(rate*qty),0) as TotalSalesVAlue, g.brandId, isNull(sum(qty),0) totalUnit, g.brandName
from tblhospitalActuals a 
RIGHT join tblSkuGroup g on g.brandId = a.brandId 
group by g.brandId, g.brandName 

 
SET NOCOUNT OFF;   
 
 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSVIVF_REPORT_GET_BUSINESS_TRACKER_All_reports]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------  
 -- CREATED BY: GURU SINGH  
 -- CREATED DATE: 24-SEP-2022  
 --------------------------------------------  
 -- exec USP_BSVIVF_REPORT_GET_RCAgreement null, 999, null, null
CREATE PROCEDURE [BSV_IVF].[USP_BSVIVF_REPORT_GET_BUSINESS_TRACKER_All_reports] 
(  
    @hospitalId int = null,  
    @empId INT = null,
    @startDate smallDateTime = null,
    @endDate smallDateTime = null 
)  
AS  
SET NOCOUNT ON;  


select s.medicineName, isNull(round(sum(rate*qty),2),0) as TotalSalesVAlue, isNull(Qty,0) as Qty , 
isNull(a.brandId, 0) as brandId, g.brandName, ABS(CHECKSUM(NewId())) % 25 as Targets
from tblhospitalActuals a
RIGHT OUTER JOIN tblSKUs s on s.medID = a.skuId
inner join tblSkuGroup g on g.brandId = s.brandId
GROUP by  s.medicineName, qty, a.brandId , g.brandName
ORDER BY TotalSalesVAlue DESC

-- OLD QUERY 

-- select s.medicineName, round(sum(rate*qty),2) as TotalSalesVAlue, Qty , 
-- a.brandId, g.brandName,
-- ABS(CHECKSUM(NewId())) % 25 as Targets 
-- from tblhospitalActuals a
-- inner join tblSKUs s on s.medID = a.skuId
-- inner join tblSkuGroup g on g.brandId = a.brandId

-- GROUP by  s.medID, s.medicineName, qty, a.brandId, g.brandName


SET NOCOUNT OFF;  



GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_BSVIVF_REPORT_GET_RCAgreement]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------  
 -- CREATED BY: GURU SINGH  
 -- CREATED DATE: 24-SEP-2022  
 --------------------------------------------  
 -- exec USP_BSVIVF_REPORT_GET_RCAgreement null, 999, null, null
CREATE PROCEDURE [BSV_IVF].[USP_BSVIVF_REPORT_GET_RCAgreement] 
(  
    @hospitalId int = null,  
    @empId INT = null,
    @startDate smallDateTime = null,
    @endDate smallDateTime = null 
)  
AS  
SET NOCOUNT ON;  


CREATE TABLE #empHierarchy
(
    levels smallInt,
    EmpID INT,
    ParentId int
)
CREATE TABLE #tmpEmployee
(
    EmpID INT,
    ParentId int,
    EmpNumber NVARCHAR(200),
    FIRSTName nvarchar(200),
    Designation nvarchar(200),
    DesignationID int,
    zoneId int
);
;WITH     
        RecursiveCte     
        AS     
        (     
            SELECT 1 as Level, H1.EmpID, H1.ParentId     
                FROM tblHierarchy H1     
                WHERE H1.isdisabled = 0 and (@empid = 999 or ParentID = @empid)     
            UNION ALL     
                SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId     
                FROM tblHierarchy H2     
                    INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID and h2.isDisabled = 0     
        )     
    insert into #empHierarchy     
        (levels, EmpID, ParentId )     
    SELECT Level, EmpID, ParentId     
    FROM RecursiveCte r     
    ;     
  --  select * from #empHierarchy
    INSERT into #tmpEmployee     
        (EmpID, ParentId, EmpNumber, FIRSTName, Designation, DesignationID, zoneId)     
            select e.EmpID, ParentID, e.EmpNumber, e.firstName, e.Designation, e.DesignationID, e.ZoneID     
            from #empHierarchy r     
            INNER join tblEmployees e on r.empID = e.EmpID 
             where e.isDisabled = 0 and ParentId <> -1
  
   -- select * from #tmpEmployee  
        SELECT  e.ParentId as rbmId,      
            ee.firstName as RBM
           , count(h.hospitalId) as hospitalCount, 
             (
             select count(*) from tblEmpHospitals eh
                inner join tblhospitalSCONTRACTS hc on hc.hospitalID = eh.hospitalId and hc.contractEndDate > GETDATE()
            where empID in (select empID from tblHierarchy where parentID in (e.ParentId))
         ) as contract 
            FROM #tmpEmployee e
            INNER join tblEmployees ee on ee.EmpID = e.ParentId   
            RIGHT JOIN tblEmpHospitals eh on eh.empId = e.empId
            LEFT join tblhospitals h on h.hospitalId = eh.hospitalId
            group by  e.ParentId, ee.firstName
            order by ee.firstName ASC
        

        DROP TABLE #empHierarchy 
        DROP TABLE #tmpEmployee 
SET NOCOUNT OFF;  



GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_CHECK_IF_POTENTIAL_EXISTS_IF_NOT_ADD_ONE]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_CHECK_IF_POTENTIAL_EXISTS_IF_NOT_ADD_ONE 52
--------------------------------------------     
-- CREATED BY: GURU SINGH     
-- CREATED DATE: 24-SEP-2022     
--------------------------------------------     
CREATE PROCEDURE [BSV_IVF].[USP_CHECK_IF_POTENTIAL_EXISTS_IF_NOT_ADD_ONE]     
( 
    @parentId int
) 
AS     
SET NOCOUNT on;    
        BEGIN  
        DECLARE @empId int,
                @hospitalId int;

        DECLARE _CURSOR CURSOR READ_ONLY FOR
           select hospitalId, EmpID from tblEmpHospitals where empID in (select empId from tblHierarchy where parentID = @parentId)
            OPEN  _CURSOR    
           FETCH NEXT FROM _CURSOR INTO
                @hospitalId, @empId
            WHILE @@FETCH_STATUS = 0
            BEGIN        
               
                    if not exists (select top 1 * from tblhospitalsPotentials where 
                            PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0) 
                            and empId  = @empId and hospitalId = @hospitalId
                    )
                        BEGIN
                            INSERT INTO tblhospitalsPotentials (empId, hospitalId, IUICycle, IVFCycle, FreshPickUps, SelftCycle, DonorCycles, AgonistCycles, IsActive, PotentialEnteredFor, frozenTransfers, Antagonistcycles)
                            select top 1 empId, hospitalId, IUICycle, IVFCycle, FreshPickUps, SelftCycle, DonorCycles, AgonistCycles, 0, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0) , frozenTransfers, Antagonistcycles from tblhospitalsPotentials where 
                            empId  = @empId and hospitalId = @hospitalId order by potentialId DESC
                        END
                
                 PRINT @empId
                 print @hospitalId
                -- FETCH _CURSOR INTO  @empId
                FETCH NEXT FROM _CURSOR INTO
                     @hospitalId, @empId
            END
            CLOSE   _CURSOR
            DEALLOCATE  _CURSOR
        end
set NOCOUNT off;


GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_CREATE_RBM_RATE_CONTRACT]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 
USP_CREATE_RBM_RATE_CONTRACT 'sinedic', '12-Jan-2023', 1025, 52, 5 
select * from tblchainAccountType 
 
*/ 
--------------------------------------------        
-- CREATED BY: GURU SINGH        
-- CREATED DATE: 24-SEP-2022        
--------------------------------------------     
CREATE PROCEDURE [BSV_IVF].[USP_CREATE_RBM_RATE_CONTRACT] 
    ( 
    @contractDoc NVARCHAR(500), 
    @expiryDate DATE, 
    @CustomerAccountId int, 
    @rbmId int, 
    @accountId int,
    @startDate Date

) 
as 
set nocount on; 
BEGIN 
    -- set @accountId = null; 
    if @accountId = 0       
        BEGIN 
             
            INSERT INTO tblchainAccountType 
                (contractDoc, expiryDate, rbmId, customerAccountID, startDate) 
            VALUES 
                (@contractDoc, @expiryDate, @rbmId, @CustomerAccountId, @startDate) 
            select @@IDENTITY as outCome; 
        END             
    ELSE                
        BEGIN 
            update tblchainAccountType                     
            set contractDoc = @contractDoc,               
                expiryDate = @expiryDate,
                startDate = @startDate     
            where accountID = @accountId 
        END 
end 
set nocount off;      


GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_DELETE_CHAIN_ACCOUNT]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
USP_DELETE_CHAIN_ACCOUNT 1
*/ 
------------------------------- 
-- CREATED BY: GURU SINGH 
-- CREATED DATE: 26-NOV-2022 
------------------------------- 
CREATE PROCEDURE [BSV_IVF].[USP_DELETE_CHAIN_ACCOUNT]  
(
    @accountId int
)
AS   
SET NOCOUNT ON;   
        UPDATE tblChainAccountType
            SET isDisabled = 1
        where accountid = @accountId
SET NOCOUNT OFF;   






GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_DELETE_CUSTSOMER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 ------------------------------- 
 -- CREATED BY: GURU SINGH 
 -- CREATED DATE: 26-NOV-2022 
 ------------------------------- 
CREATE PROCEDURE [BSV_IVF].[USP_DELETE_CUSTSOMER]  
    (        
        @customerId INT  
    )   
    AS   
    SET NOCOUNT ON;       
        BEGIN       
            -- UPDATE         
            UPDATE tblCustomers SET            
                isDisabled = 1         
            where customerId = @customerId     
        END 
    SET NOCOUNT OFF;   
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_DELETE_SKU]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------  
-- CREATED BY: GURU SINGH  
-- CREATED DATE: 24-SEP-2022  
--------------------------------------------  
create PROCEDURE [BSV_IVF].[USP_DELETE_SKU]  
(
    @skuId int
)
AS  
SET NOCOUNT on; 
        BEGIN
          update tblSKUs SET
            isDisabled = 1
          where medID = @skuId
        END
SET NOCOUNT OFF;  
  

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ETL_CHECK_AND_INSERT_Account]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BSV_IVF].[USP_ETL_CHECK_AND_INSERT_Account]
(
    @AccountName NVARCHAR(50)
)
as
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM tblAccount WHERE AccountName = TRIM(@AccountName))
            BEGIN
                INSERT INTO tblAccount (AccountName, isactive)
                VALUES (TRIM(@AccountName), 0)
            END
    END

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ETL_CHECK_AND_INSERT_SPECIALTYTYPE]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BSV_IVF].[USP_ETL_CHECK_AND_INSERT_SPECIALTYTYPE]
(
    @Name NVARCHAR(50)
)
as
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM tblSpecialtyType WHERE NAME = TRIM(@Name))
            BEGIN
                INSERT INTO tblSpecialtyType (Name, isDisabled)
                VALUES (TRIM(@Name), 0)
            END
    END
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_ETL_CHECK_AND_INSERT_VISITTYPE]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BSV_IVF].[USP_ETL_CHECK_AND_INSERT_VISITTYPE]
(
    @Name NVARCHAR(50)
)
as
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM tblVisitType WHERE NAME = TRIM(@Name))
            BEGIN
                INSERT INTO tblVisitType (Name, isDisabled)
                VALUES (TRIM(@Name), 0)
            END
    END
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ADD_UPDATE_CENTER_POTENTIAL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_MY_CENTER_LIST 24     
--------------------------------------------       
-- CREATED BY: GURU SINGH       
-- CREATED DATE: 24-SEP-2022       
--------------------------------------------       
CREATE PROCEDURE [BSV_IVF].[USP_GET_ADD_UPDATE_CENTER_POTENTIAL]       
(     
    @empId int,    
    @hospitalId int,    
    @IUICycle  int,    
    @IVFCycle int,    
    @FreshPickUps int,    
    @SelftCycle int,    
    @DonorCycles int,    
    @AgonistCycles int,    
    @frozenTransfers  int,    
    @Antagonistcycles int,    
    @Month int,     
    @Year int, 
    @visitID tinyint = null    
)     
AS       
SET NOCOUNT on;      
        BEGIN     
        declare @PotentialEnteredFor smallDateTime    
        set  @PotentialEnteredFor = (DATEFROMPARTS (@Year, @Month, 1))    
    
            IF NOT EXISTS (SELECT 1 FROM TblHospitalsPotentials WHERE empId = @empId and hospitalId = @hospitalId and PotentialEnteredFor = @PotentialEnteredFor)    
                BEGIN    
                    INSERT INTO TblHospitalsPotentials (empId, hospitalId, IUICycle,  IVFCycle, FreshPickUps, SelftCycle,     
                        DonorCycles, AgonistCycles, IsActive, PotentialEnteredFor,  frozenTransfers, Antagonistcycles, visitID, finalstatus)    
                    VALUES (@empId, @hospitalId, @IUICycle,  @IVFCycle, @FreshPickUps, @SelftCycle,     
                        @DonorCycles, @AgonistCycles, 0, @PotentialEnteredFor,  @frozenTransfers, @Antagonistcycles, @visitID, 1)    
                        select 'true' as sucess, 'Potentials created sucessfully' as msg   
                END    
            ELSE    
                BEGIN    
                    UPDATE  TblHospitalsPotentials SET    
                        IUICycle = @IUICycle,      
                        IVFCycle = @IVFCycle,     
                        FreshPickUps = @FreshPickUps,     
                        SelftCycle = @SelftCycle,     
                        DonorCycles = @DonorCycles,     
                        AgonistCycles = @AgonistCycles,    
                        frozenTransfers = @frozenTransfers,     
                        Antagonistcycles = @Antagonistcycles,  
                        isApproved = 1, 
                        finalstatus = 1 ,
                        visitID = @visitID       
                    WHERE empId = @empId and hospitalId = @hospitalId and PotentialEnteredFor = @PotentialEnteredFor    
                     select 'true' as sucess, 'Potentials updated sucessfully' as msg   
                END    
        END     
SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ADD_UPDATE_CENTER_POTENTIALv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_MY_CENTER_LIST 24     

--------------------------------------------       

-- CREATED BY: GURU SINGH       

-- CREATED DATE: 24-SEP-2022       

--------------------------------------------       

CREATE PROCEDURE [BSV_IVF].[USP_GET_ADD_UPDATE_CENTER_POTENTIALv1]       

(     

    @empId int,    

    @hospitalId int,    

    @IUICycle  int,    

    @IVFCycle int,    

    @FreshPickUps int,    

    @SelftCycle int,    

    @DonorCycles int,    

    @AgonistCycles int,    

    @frozenTransfers  int,    

    @Antagonistcycles int,    

    @Month int,     

    @Year int, 

    @visitID tinyint = null    

)     

AS       

SET NOCOUNT on;      

        BEGIN     

        declare @PotentialEnteredFor smallDateTime    

        set  @PotentialEnteredFor = (DATEFROMPARTS (@Year, @Month, 1))    

    

            IF NOT EXISTS (SELECT 1 FROM TblHospitalsPotentials WHERE empId = @empId and hospitalId = @hospitalId and PotentialEnteredFor = @PotentialEnteredFor)    

                BEGIN    

                    INSERT INTO TblHospitalsPotentials (empId, hospitalId, IUICycle,  IVFCycle, FreshPickUps, SelftCycle,     

                        DonorCycles, AgonistCycles, IsActive, PotentialEnteredFor,  frozenTransfers, Antagonistcycles, visitID, finalstatus)    

                    VALUES (@empId, @hospitalId, @IUICycle,  @IVFCycle, @FreshPickUps, @SelftCycle,     

                        @DonorCycles, @AgonistCycles, 0, @PotentialEnteredFor,  @frozenTransfers, @Antagonistcycles, @visitID, 1)    

                        select 'true' as sucess, 'Potentials created sucessfully' as msg   

                END    

            ELSE    

                BEGIN    

                    UPDATE  TblHospitalsPotentials SET    

                        IUICycle = @IUICycle,      

                        IVFCycle = @IVFCycle,     

                        FreshPickUps = @FreshPickUps,     

                        SelftCycle = @SelftCycle,     

                        DonorCycles = @DonorCycles,     

                        AgonistCycles = @AgonistCycles,    

                        frozenTransfers = @frozenTransfers,     

                        Antagonistcycles = @Antagonistcycles,  

                        isApproved = 1, 

                        finalstatus = 1 ,

                        visitID = @visitID       

                    WHERE empId = @empId and hospitalId = @hospitalId and PotentialEnteredFor = @PotentialEnteredFor    

                     select 'true' as sucess, 'Potentials updated sucessfully' as msg   

                END    

        END     

SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ALL_SKU_BUSINESS_TRACKER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_ALL_SKU_BUSINESS_TRACKER 
--------------------------------------------    
-- CREATED BY: GURU SINGH    
-- CREATED DATE: 24-SEP-2022    
--------------------------------------------    
CREATE PROCEDURE [BSV_IVF].[USP_GET_ALL_SKU_BUSINESS_TRACKER]    
AS    
SET NOCOUNT on;   
        BEGIN  
            SELECT sg.brandId, sg.brandName, bg.brandGroupId, bg.groupName, s.medid, s.medicineName, s.Price    
            FROM tblSKUs s 
            INNER JOIN tblbrandGroups bg ON bg.brandGroupId = s.brandGroupId
            INNER JOIN tblSkuGroup sg ON s.brandId = sg.brandId
            WHERE s.isDisabled = 0
            ORDER BY sg.SORTORDER asc 
        END  
SET NOCOUNT OFF;  


GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_BUSINESS_REPORT_FOR_EXCEL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [BSV_IVF].[USP_GET_BUSINESS_REPORT_FOR_EXCEL]  
 (
    @month int,
    @year int
)
AS  
 
BEGIN  
   declare @dateAddedFor smallDateTime    
    set  @dateAddedFor = (DATEFROMPARTS (@Year, @Month, 1))  
  
 
SELECT   
 
bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,   
 
bsv_ivf.getMyRBMInfo(e.empid) AS RBM,   
 
-- e.empid,    
 
e.firstName as KamName, e.Designation,    
 
  
 
CENTRENAME, DoctorName, CITY,  hospitalId,                   
/* 
 
 
 
*/ 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 1, @month, @year) as '[FOLIGRAF 900 IU/1.5 ML PEN]', 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 2, @month, @year) as '[FOLIGRAF 1200 IU/2 ML PEN] ', 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 3, @month, @year) as '[FOLIGRAF 450 IU/0.75 ML PEN]', 
            BSV_IVF.getActualsTargetAchieved(hospitalID, 1) as [FOLIGRAF PEN],                  
 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 4, @month, @year) as [FOLIGRAF 1200 IU LYO MULTIDOSE],                   
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 5, @month, @year) as [Foligraf 150 iu],                   
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 6, @month, @year) as [Foligraf 150 iu PFS],                   
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 7, @month, @year) as [Foligraf 225 PFS],                   
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 8, @month, @year) as [Foligraf 300 PFS],                   
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 9, @month, @year) as [Foligraf 75 iu],                   
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 10, @month, @year) as [Foligraf 75 iu PFS],       
            BSV_IVF.getActualsTargetAchieved(hospitalID, 2) as [FOLIGRAF (LYO/PFS)],     
 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 11, @month, @year) as [HP Humog 150 iu],  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 12, @month, @year) as [HP Humog 75 iu],  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 13, @month, @year) as [HuMoG  225 IU BP (Freeze Dried)],  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 14, @month, @year) as [Humog 150 iu],  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 15, @month, @year) as [Humog 75 iu],  
            BSV_IVF.getActualsTargetAchieved(hospitalID, 3) as [HUMOG LYO],   
  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 16, @month, @year) as [Humog HD 1200 IU Liquid],  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 17, @month, @year) as [Humog HD 600 IU Liquid],  
            BSV_IVF.getActualsTargetAchieved(hospitalID, 4) as [HUMOG LIQ (MD/PFS)],                   
 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 18, @month, @year) as [ASPORELIX],  
            -- BSV_IVF.getActualsTargetAchieved(hospitalID, 5) as [ASPORELIX],                   
 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 19, @month, @year) as [r – Hucog 6500 i.u. /0.5 ml],  
            --BSV_IVF.getActualsTargetAchieved(hospitalID, 6) as [R-HUCOG],                   
 
 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 20, @month, @year) as [Foliculin 150 iu],  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 21, @month, @year) as [Foliculin 75 iu],  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 22, @month, @year) as [HP Foliculin 150 iu],  
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 23, @month, @year) as [HP Foliculin 75 iu],  
            BSV_IVF.getActualsTargetAchieved(hospitalID, 7) as [FOLICULIN],                   
 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 24, @month, @year) as [Agotrig 0.1mg/ml in PFS TFD],  
            -- BSV_IVF.getActualsTargetAchieved(hospitalID, 8) as 'AGOTRIG',                  
 
 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 25, @month, @year) as [Dydrogesterone 10mg],  
            --BSV_IVF.getActualsTargetAchieved(hospitalID, 9) as MIDYDROGEN ,                 
 
 
            BSV_IVF.getActualsTargetAchieved_SKU(hospitalID, 38, @month, @year) as [SPRIMEO],  
            --BSV_IVF.getActualsTargetAchieved(hospitalID, 10) as SPRIMEO,                 
 
            ha.isApproved, accountName,    
 
            case ha.isApproved                         
 
                when 1 then 'Pending'                         
 
when 0 then 'Approved'                         
 
                when 2 then 'Rejected'               
 
            end as statusText,                     
 
            case ha.isApproved                         
 
                when 1 then 0                         
 
                when 0 then 1                         
 
                when 2 then 2                     
 
            end as sortOrder,  
 
            bsv_ivf.getEMPInfo(ha.approvedBy) AS ApprovedBy,   
 
            isNull(ha.approvedOn, '') as ApprovedOn,   
 
            bsv_ivf.getEMPInfo(ha.rejectedBy) AS RejectedBy,     
 
            ha.rejectedOn,   
 
            -- ha.rejectComments,   
 
            ha.ActualEnteredFor                  
 
            from TblHospitalactuals HA           
 
            inner join tblEmployees e on ha.empID = e.empID  
 
            INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                               
 
            INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                                
 
            left OUTER JOIN tblAccount a on a.accountID = c.accountID         
 
            WHERE 1 = 1                     
 
              and ActualEnteredFor = @dateAddedFor                       
 
            -- and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                        
 
            AND HA.isDisabled = 0                   
 
            group by CENTRENAME, DoctorName, CITY, hospitalId  , ha.isApproved, accountName,  
 
            e.empId,        ha.approvedBy   , ha.ApprovedOn   , ha.rejectedBy,   ha.rejectedOn,  
 
            firstName, Designation  
 
            -- , ha.rejectComments  
 
            , ha.ActualEnteredFor       
 
            order by e.firstName ASC    
 
  
 
  
 
END  
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_BUSINESS_TRACKER_DETAILS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_BUSINESS_TRACKER_DETAILS 31, 11, 2022
  -------------------------------       
   -- CREATED BY: GURU SINGH       
   -- CREATED DATE: 26-NOV-2022       
   -------------------------------       
   CREATE PROCEDURE [BSV_IVF].[USP_GET_BUSINESS_TRACKER_DETAILS]   
   ( 
       @customerId int,
       @month int,
       @year int 
   )           
    AS           
        SET NOCOUNT ON;                   
            BEGIN                     
                declare @actualEnteredFor smallDateTime 
                set  @actualEnteredFor = (DATEFROMPARTS (@Year, @Month, 1)) 
                select * from tblhospitalActuals where hospitalId = @customerId 
                and ActualEnteredFor = @actualEnteredFor and isDisabled = 0         
            END         
        SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_CENTERLIST_FOR_RBM_V1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_CENTERLIST_FOR_RBM_V1 52     
--------------------------------------------           
-- CREATED BY: GURU SINGH           
-- CREATED DATE: 24-SEP-2022           
--------------------------------------------        
CREATE PROCEDURE [BSV_IVF].[USP_GET_CENTERLIST_FOR_RBM_V1]       
(         
  @parentID int     
  )     
  as         
    -- set nocount on;             
      BEGIN                 
        SELECT   
        -- top 10                    
            a.accountName, a.accountId as aid,       
            case   
              when cat.isApproved = 1 then 'Approval Pending'   
              when cat.isApproved = 0 then 'Approved'   
              when cat.expiryDate < getdate() then 'Expired'   
              when cat.accountID is null then 'No Contract'   
            end as RateContractStatus,  
            case   
              when cat.isApproved = 1 then 0   
              when cat.isApproved = 0 then 1
              when cat.expiryDate < getdate() then 3   
              when cat.accountID is null then 4
            end as sortOrder, 
            isNull(cat.accountID, 0) as CatAccountId,   
            (select count(*) from TblContractDetails where isdisabled = 0 and chainAccountTypeId = cat.accountID) as SKUDetails,   
            c.* from tblCustomers C                  
            INNER JOIN tblEmpHospitals eh ON EH.hospitalId = c.customerId                
            INNER JOIN tblHierarchy H ON EH.EmpID = H.EmpID                 
            INNER JOIN tblaccount a on c.accountID = a.accountID     
            left join tblchainAccountType cat on cat.customerAccountID = c.accountID and  cat.isDisabled = 0           
            WHERE c.isdisabled = 0 and h.parentID = @parentID  and c.specialtyId in (2)     
            order by sortOrder ASC               
        END         
    -- set nocount off; 
 
 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_CHAIN_ACCOUNT_DETAILS_BY_ID]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
USP_GET_CHAIN_ACCOUNT_DETAILS_BY_ID 1
*/ 
------------------------------- 
-- CREATED BY: GURU SINGH 
-- CREATED DATE: 26-NOV-2022 
------------------------------- 
CREATE PROCEDURE [BSV_IVF].[USP_GET_CHAIN_ACCOUNT_DETAILS_BY_ID]  
(
    @accountId int
)
AS   
SET NOCOUNT ON;   
       select *
         from tblChainAccountType ca
        where accountid = @accountId
SET NOCOUNT OFF;   






GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_CHAIN_ACCOUNT_LIST]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 /*   USP_GET_CHAIN_ACCOUNT_LIST  */   
-------------------------------   
-- CREATED BY: GURU SINGH   
-- CREATED DATE: 26-NOV-2022   
-------------------------------   
CREATE PROCEDURE [BSV_IVF].[USP_GET_CHAIN_ACCOUNT_LIST]    
AS     
    SET NOCOUNT ON;            
        select ca.accountID, ca.name,           
            CASE              
                WHEN ca.isDisabled = 0 THEN 'Yes'
                    ELSE 'No'          
            END as isDisabled           
        from tblChainAccountType ca              
        left outer join TblContractDetails cd on ca.accountID = cd.chainAccountTypeId          
        where ca.isDisabled = 0             
        group by ca.name, ca.isDisabled, ca.accountID  
    SET NOCOUNT OFF;        
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_COMPETITION_LIST_FOR_RBM]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_COMPETITION_LIST_FOR_RBM 61    
CREATE   PROCEDURE [BSV_IVF].[USP_GET_COMPETITION_LIST_FOR_RBM] (          
    @KamId int         
)          
AS          
    BEGIN          
       -- declare @competitionAddedFor smallDateTime          
        -- set  @competitionAddedFor = (DATEFROMPARTS (@Year, @Month, 1))          
        select centerId, c.CENTRENAME, c.DoctorName, c.City, c.SpecialtyId, st.name,       
            month(com.competitionAddedFor) as month, Year(com.competitionAddedFor) as year, com.isApproved,     
            accountName,     
            case com.isApproved    
                when 1 then 'Pending'    
                when 0 then 'Approved'    
                when 2 then 'Rejected'    
            end as statusText,    
            case com.isApproved    
                when 1 then 0    
                when 0 then 1    
                when 2 then 2    
            end as sortOrder    
        from tblCompetitions com         
        inner join tblCustomers c on com.centerID = c.customerId         
        left outer join tblAccount a on a.accountID = c.accountID     
        inner join tblSpecialtyType st on st.SpecialtyId = c.SpecialtyId         
        where      
        1 = 1     
       and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)     
       --  and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)     
        and empID = @KamId -- and com.isApproved = 1        
        GROUP by centerId, c.CENTRENAME, c.DoctorName, c.City, c.SpecialtyId, st.name ,       
        month(com.competitionAddedFor), Year(com.competitionAddedFor), com.isApproved , accountName       
        order by sortOrder ASC    
         
   
         
   
      select sg.brandName, bcs.name, com.CompetitionId, com.CompetitionSkuId, centerId, c.CENTRENAME, c.DoctorName, c.City,     
        month(com.competitionAddedFor) as month, Year(com.competitionAddedFor) as year, com.isApproved,    
          case com.isApproved    
                when 1 then 'Pending'    
                when 0 then 'Approved'    
                when 2 then 'Rejected'    
            end as statusText,    
            case com.isApproved    
                when 1 then 0    
                when 0 then 1    
                when 2 then 2    
            end as sortOrder,    
      com.businessValue   
        from tblCompetitions com    
        inner join tblSkuGroup sg on sg.brandId = com.brandId   
        inner join tblBrandcompetitorSKUs bcs on bcs.competitorId = com.CompetitionSkuId   
         inner join tblCustomers c on com.centerID = c.customerId         
        where      
       bcs.isDisabled = 0   
       and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)     
       -- and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)     
        and empID = @KamId   
           
   
    END    
   
  
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_COMPETITION_LIST_FOR_RBMv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_COMPETITION_LIST_FOR_RBM 61    



CREATE   PROCEDURE [BSV_IVF].[USP_GET_COMPETITION_LIST_FOR_RBMv1] (          
    @KamId int         
)          

AS          

    BEGIN          

       -- declare @competitionAddedFor smallDateTime          

        -- set  @competitionAddedFor = (DATEFROMPARTS (@Year, @Month, 1))          

        select centerId, c.CENTRENAME, c.DoctorName, c.City, c.SpecialtyId, st.name,       

            month(com.competitionAddedFor) as month, Year(com.competitionAddedFor) as year, com.isApproved,     

            accountName,     

            case com.isApproved    



                when 1 then 'Pending'    



                when 0 then 'Approved'    



                when 2 then 'Rejected'    



            end as statusText,    



            case com.isApproved    



                when 1 then 0    



                when 0 then 1    



                when 2 then 2    



            end as sortOrder    



        from tblCompetitions com         



        inner join tblCustomers c on com.centerID = c.customerId         



        left outer join tblAccount a on a.accountID = c.accountID     



        inner join tblSpecialtyType st on st.SpecialtyId = c.SpecialtyId         



        where      



        1 = 1     



      -- and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)     



        and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)     



        and empID = @KamId -- and com.isApproved = 1        



        GROUP by centerId, c.CENTRENAME, c.DoctorName, c.City, c.SpecialtyId, st.name ,       



        month(com.competitionAddedFor), Year(com.competitionAddedFor), com.isApproved , accountName       



        order by sortOrder ASC    



         



   



         



   



      select sg.brandName, bcs.name, com.CompetitionId, com.CompetitionSkuId, centerId, c.CENTRENAME, c.DoctorName, c.City,     



        month(com.competitionAddedFor) as month, Year(com.competitionAddedFor) as year, com.isApproved,    



          case com.isApproved    



                when 1 then 'Pending'    



                when 0 then 'Approved'    



                when 2 then 'Rejected'    



            end as statusText,    



            case com.isApproved    



                when 1 then 0    



                when 0 then 1    



                when 2 then 2    



            end as sortOrder,    



      com.businessValue   



        from tblCompetitions com    



        inner join tblSkuGroup sg on sg.brandId = com.brandId   



        inner join tblBrandcompetitorSKUs bcs on bcs.competitorId = com.CompetitionSkuId   



         inner join tblCustomers c on com.centerID = c.customerId         



        where      



       bcs.isDisabled = 0   



       --and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)     



        and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)     



        and empID = @KamId   



           



   



    END    



   

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_COMPETITION_LIST_FOR_ZBM]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_COMPETITION_LIST_FOR_ZBM 61     
CREATE   PROCEDURE [BSV_IVF].[USP_GET_COMPETITION_LIST_FOR_ZBM] (            
    @KamId int           
)            
AS            
    BEGIN            
       -- declare @competitionAddedFor smallDateTime            
        -- set  @competitionAddedFor = (DATEFROMPARTS (@Year, @Month, 1))            
        select centerId, c.CENTRENAME, c.DoctorName, c.City, c.SpecialtyId, st.name,         
            month(com.competitionAddedFor) as month, Year(com.competitionAddedFor) as year, isnull(com.isZBMApproved, 1) as isApproved,       
            accountName,       
            -- case com.isApproved      
            --     when 1 then 'Pending'      
            --     when 0 then 'Approved'      
            --     when 2 then 'Rejected'      
            -- end as RBMstatusText,      
            case com.isZBMApproved      
                when 1 then 'Pending'      
                when 0 then 'Approved'      
                when 2 then 'Rejected'      
            end as statusText,     
            case com.isZBMApproved      
                when 1 then 0      
                when 0 then 1      
                when 2 then 2      
            end as sortOrder      
        from tblCompetitions com           
        inner join tblCustomers c on com.centerID = c.customerId           
         left outer JOIN tblAccount a on a.accountID = c.accountID       
        inner join tblSpecialtyType st on st.SpecialtyId = c.SpecialtyId           
        where        
        1 = 1       
        and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)       
        -- and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)       
        and empID = @KamId and com.isApproved <> 1      
        GROUP by centerId, c.CENTRENAME, c.DoctorName, c.City, c.SpecialtyId, st.name ,         
        month(com.competitionAddedFor), Year(com.competitionAddedFor), com.isApproved , accountName , com.isZBMApproved        
        order by sortOrder ASC      
           
    
    
           
     
      select sg.brandName, bcs.name, com.CompetitionId, com.CompetitionSkuId, centerId, c.CENTRENAME, c.DoctorName, c.City,       
        month(com.competitionAddedFor) as month, Year(com.competitionAddedFor) as year, com.isApproved,      
          case com.isZBMApproved      
                when 1 then 'Pending'      
                when 0 then 'Approved'      
                when 2 then 'Rejected'      
            end as statusText,      
            case com.isZBMApproved      
                when 1 then 0      
                when 0 then 1      
                when 2 then 2      
            end as sortOrder,      
      com.businessValue     
        from tblCompetitions com      
        inner join tblSkuGroup sg on sg.brandId = com.brandId     
        inner join tblBrandcompetitorSKUs bcs on bcs.competitorId = com.CompetitionSkuId     
         inner join tblCustomers c on com.centerID = c.customerId           
        where        
       bcs.isDisabled = 0     
        and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)       
        -- and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)       
        and empID = @KamId and com.isApproved <> 1     
    
    END 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_COMPETITION_LIST_FOR_ZBMv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_COMPETITION_LIST_FOR_ZBM 61     



CREATE   PROCEDURE [BSV_IVF].[USP_GET_COMPETITION_LIST_FOR_ZBMv1] (            



    @KamId int           



)            



AS            



    BEGIN            



       -- declare @competitionAddedFor smallDateTime            



        -- set  @competitionAddedFor = (DATEFROMPARTS (@Year, @Month, 1))            



        select centerId, c.CENTRENAME, c.DoctorName, c.City, c.SpecialtyId, st.name,         



            month(com.competitionAddedFor) as month, Year(com.competitionAddedFor) as year, isnull(com.isZBMApproved, 1) as isApproved,       



            accountName,       



            -- case com.isApproved      



            --     when 1 then 'Pending'      



            --     when 0 then 'Approved'      



            --     when 2 then 'Rejected'      



            -- end as RBMstatusText,      



            case com.isZBMApproved      



                when 1 then 'Pending'      



                when 0 then 'Approved'      



                when 2 then 'Rejected'      



            end as statusText,     



            case com.isZBMApproved      



                when 1 then 0      



                when 0 then 1      



                when 2 then 2      



            end as sortOrder      



        from tblCompetitions com           



        inner join tblCustomers c on com.centerID = c.customerId           



         left outer JOIN tblAccount a on a.accountID = c.accountID       



        inner join tblSpecialtyType st on st.SpecialtyId = c.SpecialtyId           



        where        



        1 = 1       



        --and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)       



        and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)       



        and empID = @KamId and com.isApproved <> 1      



        GROUP by centerId, c.CENTRENAME, c.DoctorName, c.City, c.SpecialtyId, st.name ,         



        month(com.competitionAddedFor), Year(com.competitionAddedFor), com.isApproved , accountName , com.isZBMApproved        



        order by sortOrder ASC      



           



    



    



           



     



      select sg.brandName, bcs.name, com.CompetitionId, com.CompetitionSkuId, centerId, c.CENTRENAME, c.DoctorName, c.City,       



        month(com.competitionAddedFor) as month, Year(com.competitionAddedFor) as year, com.isApproved,      



          case com.isZBMApproved      



                when 1 then 'Pending'      



                when 0 then 'Approved'      



                when 2 then 'Rejected'      



            end as statusText,      



            case com.isZBMApproved      



                when 1 then 0      



                when 0 then 1      



                when 2 then 2      



            end as sortOrder,      



      com.businessValue     



        from tblCompetitions com      



        inner join tblSkuGroup sg on sg.brandId = com.brandId     



        inner join tblBrandcompetitorSKUs bcs on bcs.competitorId = com.CompetitionSkuId     



         inner join tblCustomers c on com.centerID = c.customerId           



        where        



       bcs.isDisabled = 0     



       -- and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)       



        and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)       



        and empID = @KamId and com.isApproved <> 1     



    



    END 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_CONTRACT_DETAILS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
/*  
USP_GET_CONTRACT_DETAILS 0 
*/  

-------------------------------  
-- CREATED BY: GURU SINGH  
-- CREATED DATE: 26-NOV-2022  
-------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_GET_CONTRACT_DETAILS]   
(    
  
    @chainAccountTypeId INT 
)    
AS    
SET NOCOUNT ON;    
        if @chainAccountTypeId = 0
            begin
                select 'Standard Rate' as RateType, brandId, brandGroupId, price as SkuPrice, medId from tblSKUs where isDisabled = 0 
            end
        else
            begin
                SELECT 'contract Rate' as RateType, BrandId, brandGroupId, medId, Price as SkuPrice 
                    FROM TblContractDetails WHERE chainAccountTypeId = @chainAccountTypeId and isDisabled = 0 
            end
       

SET NOCOUNT OFF; 

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_CUSTSOMER_DETAILS_BY_ID]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_GET_CUSTSOMER_DETAILS_BY_ID 54
 -------------------------------  
 -- CREATED BY: GURU SINGH  
 -- CREATED DATE: 26-NOV-2022  
 -------------------------------  
 CREATE PROCEDURE [BSV_IVF].[USP_GET_CUSTSOMER_DETAILS_BY_ID]  
    (        
     @customerId INT   
    )    
    AS    
    SET NOCOUNT ON;        
        BEGIN            
        SELECT c.*, 
            case  
                when hc.contractEndDate is null then 'NO'
                else 'YES' 
                end as isContractApplicable,
                convert(nvarchar(20), hc.contractEndDate, 106) as contractEndDate
            FROM tblCustomers c
            left outer join TblHospitalsContracts hc on hc.hospitalId = c.customerId and contractEndDate >= GETDATE()      
            WHERE customerId = @customerId      
        END  
    SET NOCOUNT OFF; 


GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_CUSTSOMER_LIST]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_CUSTSOMER_LIST 74     
  -------------------------------            
   -- CREATED BY: GURU SINGH            
   -- CREATED DATE: 26-NOV-2022            
   -------------------------------            
   CREATE PROCEDURE [BSV_IVF].[USP_GET_CUSTSOMER_LIST]        
   (      
       @empId int      
   )                
    AS                
        SET NOCOUNT ON;                        
            BEGIN                          
                SELECT 
                ISNULL(C.CENTRENAME, '-NA-') AS CENTRENAME,
                C.city,  C.DoctorName, c.mobile, c.email, c.address1,  c.Address2, c.City, c.PinCode ,
                -- C.*, 
                s.stateName,    
                '' as ChainStatusName,    
                vt.name as VisitType, st.name as specialtyType ,     
                case      
                    when   isApproved = 1 then 'No'     
                    when isApproved  = 0   then 'Yes'     
                end as IsApproved ,   
                ISNULL(a.accountName, '-NA-') AS accountName
                FROM tblCustomers c     
                    LEFT OUTER join tblAccount a on a.accountID = c.accountID      
                    inner join tblEmpHospitals eh on c.customerId = eh.hospitalId                        
                    inner join tblstate s   on s.stateID = c.stateID                     
--                   inner join tblChainStatus cs on cs.chainID = c.chainID        
                    inner join tblVisitType vt on vt.visitId = c.visitId        
                    inner join tblSpecialtyType st on st.specialtyId = c.specialtyId        
                    where c.isDisabled = 0     and eh.EmpID = @empId      
                    ORDER BY c.centrename asc                     
            END              
        SET NOCOUNT OFF;    
 
 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_EMPLOYEE_BASED_ON_DESIGNATION]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_EMPLOYEE_BASED_ON_DESIGNATION 'rbm'
-------------------------------------------
-- CREATED BY: GURU SINGH
-- CREATED DATE: 10-Mar-2023
-------------------------------------------
CREATE PROCEDURE [BSV_IVF].[USP_GET_EMPLOYEE_BASED_ON_DESIGNATION]
(
    @desingnation nvarchar(100) = null
)
AS
    BEGIN
        select h.ParentID, e.* from tblEmployees e
        inner join tblHierarchy h on h.empID = e.empID
        where e.isDisabled = 0 

        and Designation = @desingnation or @desingnation is NULL
        and e.empId > 60
        order by e.empID ASC
    END



GO
/****** Object:  StoredProcedure [BSV_IVF].[usp_get_EmployeeDetails_By_ID]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure  [BSV_IVF].[usp_get_EmployeeDetails_By_ID] ( 
    @empId int 
) 
as 
    begin 
        select * from tblEmployees where empID = @empId and isDisabled = 0 
    end
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_GET_CENTER_POTENTIAL_DETAILS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_MY_CENTER_LIST 24  
--------------------------------------------    
-- CREATED BY: GURU SINGH    
-- CREATED DATE: 24-SEP-2022    
--------------------------------------------    
CREATE PROCEDURE [BSV_IVF].[USP_GET_GET_CENTER_POTENTIAL_DETAILS]    
(  
    @empId int, 
    @hospitalId int 
)  
AS    
SET NOCOUNT on;   
        BEGIN  
 
            SELECT top 1 * FROM TblHospitalsPotentials WHERE empId = @empId and hospitalId = @hospitalId 
            order by potentialId desc 
        END  
SET NOCOUNT OFF;    
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_MARKET_INSIGHT_REPORT_FOR_EXCEL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_MARKET_INSIGHT_REPORT_FOR_EXCEL 1, 2023  
CREATE PROCEDURE [BSV_IVF].[USP_GET_MARKET_INSIGHT_REPORT_FOR_EXCEL]     
    (  
        @month int,  
        @year int  
    )  
AS    
    BEGIN    
    declare @dateAddedFor smallDateTime      
    set  @dateAddedFor = (DATEFROMPARTS (@Year, @Month, 1))    
   
select     
    bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,      
    bsv_ivf.getMyRBMInfo(e.empid) AS RBM,      
    -- e.empid,       
    e.firstName as KamName, e.Designation,       
    -- c.customerId,       
    c.CENTRENAME as centreName,  c.DoctorName,      
    c.customerId,       
    case     
    when hp.answerone = 1 then 'Yes'    
    else 'No'    
    end as 'Practice Obstetrics',    
    ( 
        select top 1 ivfcycle from TblHospitalsPotentials where HOSPITALID = c.customerId  and PotentialEnteredFor = @dateAddedFor and isActive = 0  
    ) as 'Fresh Stimulated Cycles', 
    -- hp.AnswerTwo as 'Fresh Stimulated Cycles',    
    -- hpp.IVFCycle as 'Fresh Stimulated Cycles',    
    hp.answerThreeRFSH as 'RFSH %',    
    hp.answerThreeHMG as 'HMG %',    
    hp.answerProgesterone as 'Progesterone %',    
    hp.answerFiveDydrogesterone as 'Dydrogesterone %',    
    hp.answerFiveCombination as 'Combination %',    
    hp.answerFourRHCG as 'RHCG %',    
    hp.answerFourUHCG as 'UHCG %',    
    hp.answerFourAgonistL as 'Agonist-Leuprolide %',    
    hp.answerFourAgonistT as 'Agonist-Triptorelin %',    
    hp.answerFourRHCGTriptorelin as 'Dual Trigger (R-HCG + Triptorelin) %',    
    hp.answerFourRHCGLeuprolide as 'Dual Trigger (R-HCG + Leuprolide) %',    
    case HP.isApproved          
        when 1 then 'Pending'          
        when 0 then 'Approved'          
        when 2 then 'Rejected'          
    end as statusText,          
    bsv_ivf.getEMPInfo(hp.approvedBy) AS ApprovedBy,     
    isNull(hp.approvedOn, '') as ApprovedOn,     
    bsv_ivf.getEMPInfo(hp.rejectedBy) AS RejectedBy,     
    hp.rejectedOn, hp.rejectComments, addedFor    
    from tblMarketInsights HP          
    INNER JOIN tblCustomers C ON C.CustomerID = hp.centreId   
     -- INNER JOIN TblHospitalsPotentials HPp ON HpP.HOSPITALID = hp.CENTREID  and PotentialEnteredFor = @dateAddedFor and hpp.isActive = 0  
    left outer JOIN tblAccount a on a.accountID = c.accountID       
    INNER join tblEmployees e on e.empid = hp.empId       
    where 1 = 1       
    and hp.isActive = 0   
    and addedFor = @dateAddedFor          
    --  and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)           
    order by e.firstName ASC    
       END   
  
  
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_MY_CENTER_LIST]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_MY_CENTER_LIST 76          
  --------------------------------------------            
  -- CREATED BY: GURU SINGH            
  -- CREATED DATE: 24-SEP-2022            
  --------------------------------------------          
  CREATE  PROCEDURE [BSV_IVF].[USP_GET_MY_CENTER_LIST]           
   (              
       @empId int          
   )          
   AS            
      SET NOCOUNT on;                   
          BEGIN                     
            select     
            mat.insightId,     
            isNull(c.CENTRENAME, '-NA-') as CENTRENAME, c.DoctorName, c.customerId,              
                --case                  
                 --   -- when cat.contractEndDate > getDate() then 'Yes'                 
                --    --     else 'No'                
                 --   -- end as ContractStatus,       
                 --   when getDate() between startDate and expiryDate then 'Yes'     
                 --   else 'No'     
                 --   end   
                 'NO' as ContractStatus,       
                    isNull(chainAccountTypeId, 0) as chainAccountTypeId ,             
                    a.accountName,      
                      --[BSV_IVF].getPotentialStatusforLastMonth(c.customerId) as PotentialStatus,      
                      [BSV_IVF].getPotentialStatusforLastMonthNew(c.customerId) as PotentialStatusNew,      
                    --[BSV_IVF].getBusinessStatusforLastMonth(c.customerId) as BusinessStatus,      
                    [BSV_IVF].getBusinessStatusforLastMonthNEW(c.customerId) as BusinessStatusNEW,      
                   -- [BSV_IVF].getCompetitionStatusforLastMonth(c.customerId) as CompetitionStatus,    
                      [BSV_IVF].getCompetitionStatusforLastMonth_V1(c.customerId) as CompetitionStatusNew,    
                  --  [BSV_IVF].getMarketInsightStatusforLastMonth(c.customerId) as MIStatus,    
                    [BSV_IVF].getMarketInsightStatusforLastMonthNew(c.customerId) as MIStatusNew    
                      from       
             tblCustomers c                      
              --  inner join tblaccount a on  a.accountID = c.accountID           
		  -- change the join from inner to left outer join as some hospitals doest have accountid                                                            
            left outer join tblaccount a on  a.accountID = c.accountID                                                                    
           inner join tblEmpHospitals eh on c.customerId = eh.hospitalId                      
         --   left outer join tblchainAccountType cat on cat.customerAccountID = c.accountID     
  		left outer join tblMarketInsights mat on mat.centreId = c.customerId  and mat.isActive = 0    and addedfor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)   
           -- left outer join TblHospitalsContracts hc on hc.hospitalId = c.customerId                     
            inner join tblSpecialtyType st on st.specialtyId = c.specialtyId and st.specialtyId in (2)                   
            where eh.EmpID = @empId and c.isdisabled = 0                  
        END          
    SET NOCOUNT OFF;       
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_MY_CENTER_LISTV1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_MY_CENTER_LIST 76          

  --------------------------------------------            

  -- CREATED BY: GURU SINGH            

  -- CREATED DATE: 24-SEP-2022            

  --------------------------------------------          

  CREATE  PROCEDURE [BSV_IVF].[USP_GET_MY_CENTER_LISTV1]           

   (              

       @empId int          

   )          

   AS            

      SET NOCOUNT on;                   

          BEGIN                     

            select     

            mat.insightId,     

            isNull(c.CENTRENAME, '-NA-') as CENTRENAME, c.DoctorName, c.customerId,              

                --case                  

                 --   -- when cat.contractEndDate > getDate() then 'Yes'                 

                --    --     else 'No'                

                 --   -- end as ContractStatus,       

                 --   when getDate() between startDate and expiryDate then 'Yes'     

                 --   else 'No'     

                 --   end   

                 'NO' as ContractStatus,       

                    isNull(chainAccountTypeId, 0) as chainAccountTypeId ,             

                    a.accountName,      

                      --[BSV_IVF].getPotentialStatusforLastMonth(c.customerId) as PotentialStatus,      

                      [BSV_IVF].getPotentialStatusforLastMonthNewv1(c.customerId) as PotentialStatusNew,      

                    --[BSV_IVF].getBusinessStatusforLastMonth(c.customerId) as BusinessStatus,      

                    [BSV_IVF].getBusinessStatusforLastMonthNEWv1(c.customerId) as BusinessStatusNEW,      

                   -- [BSV_IVF].getCompetitionStatusforLastMonth(c.customerId) as CompetitionStatus,    

                      [BSV_IVF].getCompetitionStatusforLastMonth_V2(c.customerId) as CompetitionStatusNew,    

                  --  [BSV_IVF].getMarketInsightStatusforLastMonth(c.customerId) as MIStatus,    

                    [BSV_IVF].getMarketInsightStatusforLastMonthNewv1(c.customerId) as MIStatusNew    

                      from       

             tblCustomers c                      

              --  inner join tblaccount a on  a.accountID = c.accountID           

		  -- change the join from inner to left outer join as some hospitals doest have accountid                                                            

            left outer join tblaccount a on  a.accountID = c.accountID                                                                    

           inner join tblEmpHospitals eh on c.customerId = eh.hospitalId                      

         --   left outer join tblchainAccountType cat on cat.customerAccountID = c.accountID     

  		left outer join tblMarketInsights mat on mat.centreId = c.customerId  and mat.isActive = 0    
		--and addedfor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)   
		and addedfor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)   

           -- left outer join TblHospitalsContracts hc on hc.hospitalId = c.customerId                     

            inner join tblSpecialtyType st on st.specialtyId = c.specialtyId and st.specialtyId in (2)                   

            where eh.EmpID = @empId and c.isdisabled = 0                  

        END          

    SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_MY_TEAM_MEMBERS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_GET_MY_TEAM_MEMBERS 47  
 -------------------------------   
 -- CREATED BY: GURU SINGH   
 -- CREATED DATE: 26-NOV-2022   
 -------------------------------   
 CREATE PROCEDURE [BSV_IVF].[USP_GET_MY_TEAM_MEMBERS]   
  (     
       @empId int  
    )  
       AS      
       BEGIN         
        set NOCOUNT on;  
 
 
CREATE TABLE #empHierarchy 
( 
    levels smallInt, 
    EmpID INT, 
    ParentId int 
) 
             
;WITH 
    RecursiveCte 
    AS 
    ( 
        SELECT 1 as Level, H1.EmpID, H1.ParentId 
            FROM tblHierarchy H1 
            WHERE (@empid is null or ParentID = @empid) 
        UNION ALL 
        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId 
            FROM tblHierarchy H2 
                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID 
    ) 
            insert into #empHierarchy 
                (levels, EmpID, ParentId ) 
            SELECT Level, EmpID, ParentId 
            FROM RecursiveCte r 
            ; 
 
                          
                         select e.empID, firstName, e.MobileNumber, email, EmpNumber, hoCode, designation, 
                                      s.StateName,              DOJ  from tblEmployees e         
                              inner join tblState s on s.stateID = e.StateID            
                                where e.empID in (select EmpID from #empHierarchy) 
                                order by designation         
        set NOCOUNT OFF;      
        END    
 
 
 
 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_POTENTIAL_REPORT_FOR_EXCEL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BSV_IVF].[USP_GET_POTENTIAL_REPORT_FOR_EXCEL]    
( 
    @month int, 
    @year int 
) 
  
as    
  
begin    
     declare @dateAddedFor smallDateTime     
    set  @dateAddedFor = (DATEFROMPARTS (@Year, @Month, 1))   
    
  
    select     
  
bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,    
  
bsv_ivf.getMyRBMInfo(e.empid) AS RBM,    
  
-- e.empid,     
  
e.firstName as KamName, e.Designation,     
  
    
  
c.CENTRENAME as centreName,  c.DoctorName,   
c.customerId,  
  
hp.IUICycle, IVFCycle, hp.FreshPickUps, hp.SelftCycle, hp.DonorCycles, hp.AgonistCycles, hp.frozenTransfers, hp.Antagonistcycles,    
  
hp.isApproved,     
  
bsv_ivf.getEMPInfo(hp.approvedBy) AS ApprovedBy,    
  
isNull(hp.approvedOn, '') as ApprovedOn,    
  
bsv_ivf.getEMPInfo(hp.rejectedBy) AS RejectedBy,    
  
hp.rejectedOn, hp.rejectComments, hp.PotentialEnteredFor,     
  
-- hp.visitId,    
  
 vt.name as visiType,    
  
    
  
case HP.isApproved                         
  
    when 1 then 'Pending'                         
  
    when 0 then 'Approved'                         
  
    when 2 then 'Rejected'                     
  
end as RBMStaus    
  
from tblEmployees e    
  
inner join TblHospitalsPotentials hp on hp.empId = e.EmpID    
  
inner join tblcustomers c on c.customerID = hp.hospitalId    
  
INNER join tblVisitType vt on vt.visitId = hp.visitID    
  
where  1 = 1    
  
 and hp.PotentialEnteredFor = @dateAddedFor      
  
-- and hp.PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)      
  
-- and e.EmpID = 63    
  
and hp.isactive = 0    
  
and e.isdisabled = 0     
  
order by e.firstName ASC     
-- order by c.CENTRENAME,  c.DoctorName, c.customerId ASC
  
    
  
end 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_RBM_BUSINESS_LIST_FOR_APPROVAL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------             
-- CREATED BY: GURU SINGH             
-- CREATED DATE: 24-SEP-2022             
--------------------------------------------             
CREATE  PROCEDURE [BSV_IVF].[USP_GET_RBM_BUSINESS_LIST_FOR_APPROVAL]             
    (             
        @KamId int        
    )         
AS             
SET NOCOUNT on;                    
    BEGIN                                                  
        SELECT CENTRENAME, DoctorName, CITY,  hospitalId,                
            BSV_IVF.getActualsTargetAchieved(hospitalID, 1) as brandGroup1,               
            BSV_IVF.getActualsTargetAchieved(hospitalID, 2) as brandGroup2,                
            BSV_IVF.getActualsTargetAchieved(hospitalID, 3) as brandGroup3,
            BSV_IVF.getActualsTargetAchieved(hospitalID, 4) as brandGroup4,                
            BSV_IVF.getActualsTargetAchieved(hospitalID, 5) as brandGroup5,                
            BSV_IVF.getActualsTargetAchieved(hospitalID, 6) as brandGroup6,                
            BSV_IVF.getActualsTargetAchieved(hospitalID, 7) as brandGroup7,                
            BSV_IVF.getActualsTargetAchieved(hospitalID, 8) as brandGroup8,                
            BSV_IVF.getActualsTargetAchieved(hospitalID, 9) as brandGroup9 ,              
            BSV_IVF.getActualsTargetAchieved(hospitalID, 10) as brandGroup10,              
            ha.isApproved, accountName, 
            case ha.isApproved                      
                when 1 then 'Pending'                      
                when 0 then 'Approved'                      
                when 2 then 'Rejected'            
            end as statusText,                  
            case ha.isApproved                      
                when 1 then 0                      
                when 0 then 1                      
                when 2 then 2                  
            end as sortOrder               
            from TblHospitalactuals HA               
            INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                            
            INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                             
            left OUTER JOIN tblAccount a on a.accountID = c.accountID      
            WHERE 1 = 1                  
            and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)                     
            -- and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                     
            and empId =  @KamId   AND HA.isDisabled = 0                
            group by CENTRENAME, DoctorName, CITY, hospitalId  , ha.isApproved, accountName                  
            order by sortOrder asc                   
            
            -- for graphs                          
                select     ha.actualId, c.CENTRENAME, c.DoctorName, c.City,                    
                ha.empId, ha.hospitalId, ha.brandId, sg.brandName, ha.brandGroupId, BG.groupName, ha.skuId, s.medicineName,                   
                ha.rate, ha.qty                  
                from TblHospitalactuals HA                            
                INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                            
                INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                            
                INNER join tblSkuGroup sg on sg.brandId = ha.brandId                           
                INNER JOIN tblSKUs s on s.medID = ha.skuId                    
                WHERE empId =  @KamId     AND HA.isDisabled = 0                
                AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)                     
                -- AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                     
                order by ha.actualId                                   
                
                select    ha.brandId, sg.brandName, s.medicineName,                   
                --ha.empId, ha.hospitalId, ha.brandId, sg.brandName, ha.brandGroupId, BG.groupName, ha.skuId, s.medicineName,                   
                ROUND(sum(ha.rate* ha.qty), 2) as TotalSalesValue                   
                from TblHospitalactuals HA                            
                INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                   
                INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                            
                INNER join tblSkuGroup sg on sg.brandId = ha.brandId             
                INNER JOIN tblSKUs s on s.medID = ha.skuId                    
                WHERE empId =  @KamId    AND HA.isDisabled = 0                
                AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)                     
                -- AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                     
                group by ha.brandId, sg.brandName, s.medicineName                       
    END        
SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_RBM_BUSINESS_LIST_FOR_APPROVALv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------             

-- CREATED BY: GURU SINGH             

-- CREATED DATE: 24-SEP-2022             

--------------------------------------------             

CREATE  PROCEDURE [BSV_IVF].[USP_GET_RBM_BUSINESS_LIST_FOR_APPROVALv1]             

    (             

        @KamId int        

    )         

AS             

SET NOCOUNT on;                    

    BEGIN                                                  

        SELECT CENTRENAME, DoctorName, CITY,  hospitalId,                

            BSV_IVF.getActualsTargetAchieved(hospitalID, 1) as brandGroup1,               

            BSV_IVF.getActualsTargetAchieved(hospitalID, 2) as brandGroup2,                

            BSV_IVF.getActualsTargetAchieved(hospitalID, 3) as brandGroup3,

            BSV_IVF.getActualsTargetAchieved(hospitalID, 4) as brandGroup4,                

            BSV_IVF.getActualsTargetAchieved(hospitalID, 5) as brandGroup5,                

            BSV_IVF.getActualsTargetAchieved(hospitalID, 6) as brandGroup6,                

            BSV_IVF.getActualsTargetAchieved(hospitalID, 7) as brandGroup7,                

            BSV_IVF.getActualsTargetAchieved(hospitalID, 8) as brandGroup8,                

            BSV_IVF.getActualsTargetAchieved(hospitalID, 9) as brandGroup9 ,              

            BSV_IVF.getActualsTargetAchieved(hospitalID, 10) as brandGroup10,              

            ha.isApproved, accountName, 

            case ha.isApproved                      

                when 1 then 'Pending'                      

                when 0 then 'Approved'                      

                when 2 then 'Rejected'            

            end as statusText,                  

            case ha.isApproved                      

                when 1 then 0                      

                when 0 then 1                      

                when 2 then 2                  

            end as sortOrder               

            from TblHospitalactuals HA               

            INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                            

            INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                             

            left OUTER JOIN tblAccount a on a.accountID = c.accountID      

            WHERE 1 = 1                  

           -- and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)  --for feb                   

             and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)  -- for jan                   

            and empId =  @KamId   AND HA.isDisabled = 0                

            group by CENTRENAME, DoctorName, CITY, hospitalId  , ha.isApproved, accountName                  

            order by sortOrder asc                   

            

            -- for graphs                          

                select     ha.actualId, c.CENTRENAME, c.DoctorName, c.City,                    

                ha.empId, ha.hospitalId, ha.brandId, sg.brandName, ha.brandGroupId, BG.groupName, ha.skuId, s.medicineName,                   

                ha.rate, ha.qty                  

                from TblHospitalactuals HA                            

                INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                            

                INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                            

                INNER join tblSkuGroup sg on sg.brandId = ha.brandId                           

                INNER JOIN tblSKUs s on s.medID = ha.skuId                    

                WHERE empId =  @KamId     AND HA.isDisabled = 0                

                --AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)   --for feb                  

                 AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)  --for jan                   

           order by ha.actualId                                   

                

                select    ha.brandId, sg.brandName, s.medicineName,                   

                --ha.empId, ha.hospitalId, ha.brandId, sg.brandName, ha.brandGroupId, BG.groupName, ha.skuId, s.medicineName,                   

                ROUND(sum(ha.rate* ha.qty), 2) as TotalSalesValue                   

                from TblHospitalactuals HA                            

                INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                   

                INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                            

                INNER join tblSkuGroup sg on sg.brandId = ha.brandId             

                INNER JOIN tblSKUs s on s.medID = ha.skuId                    

                WHERE empId =  @KamId    AND HA.isDisabled = 0                

                --AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)  --for feb                   

                 AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)   --for jan                  

                group by ha.brandId, sg.brandName, s.medicineName                       

    END        

SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_RBM_MarketInsights_LIST_FOR_APPROVAL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVAL 24     
--------------------------------------------          
-- CREATED BY: GURU SINGH          
-- CREATED DATE: 24-SEP-2022          
--------------------------------------------          
CREATE PROCEDURE [BSV_IVF].[USP_GET_RBM_MarketInsights_LIST_FOR_APPROVAL]          
(      
    @KamId int     
)      
AS          
SET NOCOUNT on;         
        BEGIN       
     
    select accountName, CENTRENAME, DoctorName, CITY,      
            case HP.isApproved     
                when 1 then 'Pending'     
                when 0 then 'Approved'     
                when 2 then 'Rejected'     
            end as statusText,     
            case HP.isApproved     
                when 1 then 0     
                when 0 then 1     
                when 2 then 2     
            end as sortOrder, HP.*     
    
            from tblMarketInsights HP     
            INNER JOIN tblCustomers C ON C.CustomerID = hp.centreId     
            left outer JOIN tblAccount a on a.accountID = c.accountID     
    where 1 = 1     
    and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)      
    -- and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)      
    and empId =  @KamId     
     order by sortOrder ASC     
     
        END     
SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_RBM_MarketInsights_LIST_FOR_APPROVALv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVAL 24     

--------------------------------------------          

-- CREATED BY: GURU SINGH          

-- CREATED DATE: 24-SEP-2022          

--------------------------------------------          

CREATE PROCEDURE [BSV_IVF].[USP_GET_RBM_MarketInsights_LIST_FOR_APPROVALv1]          

(      

    @KamId int     

)      

AS          

SET NOCOUNT on;         

        BEGIN       

     

    select accountName, CENTRENAME, DoctorName, CITY,      

            case HP.isApproved     

                when 1 then 'Pending'     

                when 0 then 'Approved'     

                when 2 then 'Rejected'     

            end as statusText,     

            case HP.isApproved     

                when 1 then 0     

                when 0 then 1     

                when 2 then 2     

            end as sortOrder, HP.*     

    

            from tblMarketInsights HP     

            INNER JOIN tblCustomers C ON C.CustomerID = hp.centreId     

            left outer JOIN tblAccount a on a.accountID = c.accountID     

    where 1 = 1     

   -- and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)  --for feb     

     and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0) -- for jan     

    and empId =  @KamId     

     order by sortOrder ASC     

     

        END     

SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVAL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     -- USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVAL 24    
     --------------------------------------------         
     -- CREATED BY: GURU SINGH         
     -- CREATED DATE: 24-SEP-2022         
     --------------------------------------------         
     CREATE PROCEDURE [BSV_IVF].[USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVAL]         
        (         
            @KamId int    
        )     
        AS         
    SET NOCOUNT on;                
        BEGIN              
            select 
                accountName, CENTRENAME, DoctorName, CITY,                 
                case HP.isApproved                    
                    when 1 then 'Pending'                    
                    when 0 then 'Approved'                    
                    when 2 then 'Rejected'                
                end as statusText,                
                case HP.isApproved                    
                    when 1 then 0                    
                    when 0 then 1                    
                    when 2 then 2                
                end as sortOrder, HP.*                   
            from tblhospitalsPotentials HP                
            INNER JOIN tblCustomers C ON C.CustomerID = hp.hospitalId                
            left OUTER JOIN tblAccount a on a.accountID = c.accountID        
            where 1 = 1        
            and PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)         
            -- and PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)         
            and empId =  @KamId         
            order by sortOrder ASC                
        END    
    SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVALv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     -- USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVAL 24    

     --------------------------------------------         

     -- CREATED BY: GURU SINGH         

     -- CREATED DATE: 24-SEP-2022         

     --------------------------------------------         

     CREATE PROCEDURE [BSV_IVF].[USP_GET_RBM_POTENTIAL_LIST_FOR_APPROVALv1]         

        (         

            @KamId int    

        )     

        AS         

    SET NOCOUNT on;                

        BEGIN              

            select 

                accountName, CENTRENAME, DoctorName, CITY,                 

                case HP.isApproved                    

                    when 1 then 'Pending'                    

                    when 0 then 'Approved'                    

                    when 2 then 'Rejected'                

                end as statusText,                

                case HP.isApproved                    

                    when 1 then 0                    

                    when 0 then 1                    

                    when 2 then 2                

                end as sortOrder, HP.*                   

            from tblhospitalsPotentials HP                

            INNER JOIN tblCustomers C ON C.CustomerID = hp.hospitalId                

            left OUTER JOIN tblAccount a on a.accountID = c.accountID        

            where 1 = 1        

            --and PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)     --for feb    

             and PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)         --for jan

            and empId =  @KamId         

            order by sortOrder ASC                

        END    

    SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_SKU_COMPETITION_DETAILS_BY_CENTER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [BSV_IVF].[USP_GET_SKU_COMPETITION_DETAILS_BY_CENTER] ( 
    @centerId int,  
    @Month int,  
    @Year int 
) 
AS 
    BEGIN 
        declare @competitionAddedFor smallDateTime 
        set  @competitionAddedFor = (DATEFROMPARTS (@Year, @Month, 1)) 
        select * from tblCompetitions 
                where  
                centerId = @centerId and competitionAddedFor = @competitionAddedFor
    END 
 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_SKU_DETAILS_BY_ID]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------  
-- CREATED BY: GURU SINGH  
-- CREATED DATE: 24-SEP-2022  
--------------------------------------------  
create PROCEDURE [BSV_IVF].[USP_GET_SKU_DETAILS_BY_ID]  
(
    @skuId int
)
AS  
SET NOCOUNT on; 
        BEGIN
          SELECT medID as SkuId, S.brandId, sg.brandName, S.brandGroupId, bg.groupName,  medicineName, price FROM tblSKUs S  
           INNER JOIN tblSkuGroup SG ON sg.brandId = s.brandId 
           INNER JOIN tblBrandGroups BG ON s.brandGroupId = bg.brandGroupId 
           where medID = @skuId
        END
SET NOCOUNT OFF;  
  

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_VIEW_PERFORMANCE_FOR_CENTER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_VIEW_PERFORMANCE_FOR_CENTER 966 
------------------------------------------------ 
-- CREATED BY: GURU SINGH 
-- CREATED DATE: 13-DEC-2022 
------------------------------------------------ 
CREATE PROCEDURE [BSV_IVF].[USP_GET_VIEW_PERFORMANCE_FOR_CENTER] 
( 
    @centerId int 
) 
AS 
set NOCOUNT on; 


CREATE TABLE #tmpCenterList 
( 
    accountId Int, 
    centerID INT
) 
    declare @accountID int 
    select @accountID = accountID from tblcustomers  c where c.customerId = @centerId 
    insert into #tmpCenterList (accountId, centerID)
    select accountID, customerId from tblcustomers  c where c.accountID = @accountID
 /*
accountId	centerID
1488	    692
1488	    1121
 */
    -- select * from #tmpCenterList
    
    select customerId, accountID, st.name as SpecialtyName, CENTRENAME, doctorName, mobile, email, city, ch.name, s.stateName from tblcustomers c 
    INNER join tblChainStatus ch on ch.chainId = c.chainId 
    INNER join tblState S on c.stateID = s.stateId 
    inner join tblSpecialtyType st on st.SpecialtyId = c.SpecialtyId 
    where c.customerId in (select centerID from #tmpCenterList)

 select 
    sum(convert(int, IUICycle)) as IUICycle, sum(convert(int, IVFCycle)) as IVFCycle
    , sum(FreshPickUps) as FreshPickUps, sum(frozenTransfers) as frozenTransfers
    , sum(SelftCycle) as  SelftCycle
    , sum(DonorCycles) as DonorCycles
    , sum(AgonistCycles) as AgonistCycles
    , sum(Antagonistcycles) as Antagonistcycles
    from tblhospitalsPotentials where hospitalId in 
    (select centerID from #tmpCenterList) and isActive = 0 and isApproved = 0
    

    if exists (select 1 from tblChainAccountType where customerAccountID = @accountID and expiryDate >= GETDATE() and isApproved = 0)    
        BEGIN

            select 'contract Rate' as RateType, BrandId, brandGroupId, medId, Price as SkuPrice
            from TblContractDetails where  
            price > 0 and 
            chainAccountTypeId in (select accountID from tblChainAccountType where customerAccountID = @accountID and expiryDate >= GETDATE() and isApproved = 0)
            -- USP_GET_VIEW_PERFORMANCE_FOR_CENTER_v1 1121
        END
    ELSE    
        BEGIN
            select 'Standard Rate' as RateType, brandId, brandGroupId, price as SkuPrice, medId from tblSKUs where isDisabled = 0  
        END
    

 drop table #tmpCenterList
set NOCOUNT off; 
 
 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_VIEW_PERFORMANCE_FOR_CENTER_v1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_VIEW_PERFORMANCE_FOR_CENTER 966 

------------------------------------------------ 

-- CREATED BY: GURU SINGH 

-- CREATED DATE: 13-DEC-2022 

------------------------------------------------ 

CREATE PROCEDURE [BSV_IVF].[USP_GET_VIEW_PERFORMANCE_FOR_CENTER_v1] 

( 

    @centerId int,

    @month int = NULL,

    @year int = NULL

) 

AS 

set NOCOUNT on; 

            declare @selectedMonthYear smallDateTime  

            if (@month is NULL)

                BEGIN

                    set  @selectedMonthYear =  DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)

                END

            ELSE

                BEGIN

                    set  @selectedMonthYear = (DATEFROMPARTS (@Year, @Month, 1))  

                END



CREATE TABLE #tmpCenterList 

( 

    accountId Int, 

    centerID INT

) 

    declare @accountID int 

    select @accountID = accountID from tblcustomers  c where c.customerId = @centerId 

    insert into #tmpCenterList (accountId, centerID)

    select accountID, customerId from tblcustomers  c where c.accountID = @accountID

 /*

accountId	centerID

1488	    692

1488	    1121

 */

--     select * from #tmpCenterList

    

    select customerId, accountID, st.name as SpecialtyName, CENTRENAME, doctorName, mobile, email, city, ch.name, s.stateName from tblcustomers c 

    INNER join tblChainStatus ch on ch.chainId = c.chainId 

    INNER join tblState S on c.stateID = s.stateId 

    inner join tblSpecialtyType st on st.SpecialtyId = c.SpecialtyId 

    where c.customerId in (select centerID from #tmpCenterList)
	and c.isdisabled = 0


 select 

    sum(convert(int, IUICycle)) as IUICycle, sum(convert(int, IVFCycle)) as IVFCycle

    , sum(FreshPickUps) as FreshPickUps, sum(frozenTransfers) as frozenTransfers

    , sum(SelftCycle) as  SelftCycle

    , sum(DonorCycles) as DonorCycles

    , sum(AgonistCycles) as AgonistCycles

    , sum(Antagonistcycles) as Antagonistcycles

    from tblhospitalsPotentials where hospitalId in 

    (select centerID from #tmpCenterList) and isActive = 0 and isApproved = 0

    



if exists (select 1 from tblChainAccountType where customerAccountID = @accountID and expiryDate >= GETDATE() and isApproved = 0)    

    BEGIN



        select 'contract Rate' as RateType, BrandId, brandGroupId, medId, Price as SkuPrice

        from TblContractDetails where  

        price > 0 and 

        chainAccountTypeId in (select accountID from tblChainAccountType where customerAccountID = @accountID and expiryDate >= GETDATE() and isApproved = 0)

        END

ELSE    

    BEGIN

        select 'Standard Rate' as RateType, brandId, brandGroupId, price as SkuPrice, medId from tblSKUs where isDisabled = 0  

    END





select ha.brandId, sg.brandName, ha.brandGroupId, bg.groupName

--, ha.skuId, s.medicineName

, sum(qty) totalQty,  FORMAT(sum (rate * Qty)/1000,'N2') as totalValue

from tblhospitalActuals ha

inner join tblSkuGroup sg on sg.brandId = ha.brandId

INNER join tblBrandGroups bg on bg.brandGroupId = ha.brandGroupId

inner join tblSKUs s on s.medID = ha.skuId

where  ha.isDisabled = 0 

and rate > 0

and ActualEnteredFor = @selectedMonthYear 

and hospitalId in (select centerID from #tmpCenterList)

and isApproved = 0

group by ha.brandId, sg.brandName, ha.brandGroupId, bg.groupName





select c.brandId, sg.brandname

-- , c.CompetitionSkuId, bck.name

, sum(c.businessValue) as TotalBusinessValue

from tblCompetitions c 

inner join tblBrandcompetitorSKUs bck on c.CompetitionSkuId = bck.competitorId

inner join tblSkuGroup sg on sg.brandId = c.brandId

where isApproved = 0 

and competitionAddedFor = @selectedMonthYear 

and centerId in (select centerID from #tmpCenterList)

GROUP by c.brandId, sg.brandname

-- , c.CompetitionSkuId, bck.name







-- USP_GET_VIEW_PERFORMANCE_FOR_CENTER_v1 1121





 drop table #tmpCenterList

set NOCOUNT off; 

 


GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ZBM_BUSINESS_LIST_FOR_APPROVAL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_GET_ZBM_BUSINESS_LIST_FOR_APPROVAL 61
 --------------------------------------------               
    -- CREATED BY: GURU SINGH               
    -- CREATED DATE: 24-SEP-2022               
--------------------------------------------              
CREATE  PROCEDURE [BSV_IVF].[USP_GET_ZBM_BUSINESS_LIST_FOR_APPROVAL]               
    (               
            @KamId int          
    )           
AS               
    SET NOCOUNT on;                      
        BEGIN                                                        
            SELECT CENTRENAME, DoctorName, CITY,  hospitalId,                  
                BSV_IVF.getActualsTargetAchieved(hospitalID, 1) as brandGroup1,                 
                BSV_IVF.getActualsTargetAchieved(hospitalID, 2) as brandGroup2,                  
                BSV_IVF.getActualsTargetAchieved(hospitalID, 3) as brandGroup3,                  
                BSV_IVF.getActualsTargetAchieved(hospitalID, 4) as brandGroup4,                  
                BSV_IVF.getActualsTargetAchieved(hospitalID, 5) as brandGroup5,                  
                BSV_IVF.getActualsTargetAchieved(hospitalID, 6) as brandGroup6,                  
                BSV_IVF.getActualsTargetAchieved(hospitalID, 7) as brandGroup7,                  
                BSV_IVF.getActualsTargetAchieved(hospitalID, 8) as brandGroup8,                  
                BSV_IVF.getActualsTargetAchieved(hospitalID, 9) as brandGroup9 ,                
                BSV_IVF.getActualsTargetAchieved(hospitalID, 10) as brandGroup10,                
                ha.ZBMApproved, accountName, 
                case ha.ZBMApproved                        
                    when 1 then 'Pending'                        
                    when 0 then 'Approved'                        
                    when 2 then 'Rejected'                    
                end as statusText,                    
                case ha.ZBMApproved                        
                    when 1 then 0                        
                    when 0 then 1                        
                    when 2 then 2                   
                end as sortOrder                 
            from TblHospitalactuals HA                              
            INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                              
            INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId
            left outer JOIN tblAccount a on a.accountID = c.accountID                    
        WHERE 1 = 1                    
        and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)                       
        -- and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                       
        and empId =  @KamId   AND HA.isDisabled = 0                 
        group by CENTRENAME, DoctorName, CITY, hospitalId, ha.ZBMApproved, accountName                    
        order by sortOrder asc        
        
        -- for graphs                              
        
        select     
            ha.actualId, c.CENTRENAME, c.DoctorName, c.City,                      
            ha.empId, ha.hospitalId, ha.brandId, sg.brandName, 
            ha.brandGroupId, BG.groupName, ha.skuId, s.medicineName,
            ha.rate, ha.qty                    
        from TblHospitalactuals HA                              
        INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                              
        INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                              
        INNER join tblSkuGroup sg on sg.brandId = ha.brandId                             
        INNER JOIN tblSKUs s on s.medID = ha.skuId                      
        WHERE empId =  @KamId     AND HA.isDisabled = 0                 
        AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)                       
        -- AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                       
        order by ha.actualId                                         
        
        select    ha.brandId, sg.brandName, s.medicineName,                     
                --ha.empId, ha.hospitalId, ha.brandId, sg.brandName, ha.brandGroupId, BG.groupName, ha.skuId, s.medicineName,                     
                ROUND(sum(ha.rate* ha.qty), 2) as TotalSalesValue                 
        from TblHospitalactuals HA                              
        INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                              
        INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                              
        INNER join tblSkuGroup sg on sg.brandId = ha.brandId                             
        INNER JOIN tblSKUs s on s.medID = ha.skuId                      
        WHERE empId =  @KamId   AND HA.isDisabled = 0                 
        AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)                       
        -- AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                       
        group by ha.brandId, sg.brandName, s.medicineName                         
    END          
SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ZBM_BUSINESS_LIST_FOR_APPROVALv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_GET_ZBM_BUSINESS_LIST_FOR_APPROVAL 61

 --------------------------------------------               

    -- CREATED BY: GURU SINGH               

    -- CREATED DATE: 24-SEP-2022               

--------------------------------------------              

CREATE  PROCEDURE [BSV_IVF].[USP_GET_ZBM_BUSINESS_LIST_FOR_APPROVALv1]               

    (               

            @KamId int          

    )           

AS               

    SET NOCOUNT on;                      

        BEGIN                                                        

            SELECT CENTRENAME, DoctorName, CITY,  hospitalId,                  

                BSV_IVF.getActualsTargetAchieved(hospitalID, 1) as brandGroup1,                 

                BSV_IVF.getActualsTargetAchieved(hospitalID, 2) as brandGroup2,                  

                BSV_IVF.getActualsTargetAchieved(hospitalID, 3) as brandGroup3,                  

                BSV_IVF.getActualsTargetAchieved(hospitalID, 4) as brandGroup4,                  

                BSV_IVF.getActualsTargetAchieved(hospitalID, 5) as brandGroup5,                  

                BSV_IVF.getActualsTargetAchieved(hospitalID, 6) as brandGroup6,                  

                BSV_IVF.getActualsTargetAchieved(hospitalID, 7) as brandGroup7,                  

                BSV_IVF.getActualsTargetAchieved(hospitalID, 8) as brandGroup8,                  

                BSV_IVF.getActualsTargetAchieved(hospitalID, 9) as brandGroup9 ,                

                BSV_IVF.getActualsTargetAchieved(hospitalID, 10) as brandGroup10,                

                ha.ZBMApproved, accountName, 

                case ha.ZBMApproved                        

                    when 1 then 'Pending'                        

                    when 0 then 'Approved'                        

                    when 2 then 'Rejected'                    

                end as statusText,                    

                case ha.ZBMApproved                        

                    when 1 then 0                        

                    when 0 then 1                        

                    when 2 then 2                   

                end as sortOrder                 

            from TblHospitalactuals HA                              

            INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                              

            INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId

            left outer JOIN tblAccount a on a.accountID = c.accountID                    

        WHERE 1 = 1                    

        --and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)        -- for feb               

         and ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)            --for jan           

        and empId =  @KamId   AND HA.isDisabled = 0                 

        group by CENTRENAME, DoctorName, CITY, hospitalId, ha.ZBMApproved, accountName                    

        order by sortOrder asc        

        

        -- for graphs                              

        

        select     

            ha.actualId, c.CENTRENAME, c.DoctorName, c.City,                      

            ha.empId, ha.hospitalId, ha.brandId, sg.brandName, 

            ha.brandGroupId, BG.groupName, ha.skuId, s.medicineName,

            ha.rate, ha.qty                    

        from TblHospitalactuals HA                              

        INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                              

        INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                              

        INNER join tblSkuGroup sg on sg.brandId = ha.brandId                             

        INNER JOIN tblSKUs s on s.medID = ha.skuId                      

        WHERE empId =  @KamId     AND HA.isDisabled = 0                 

        --AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)                       --for feb

         AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                       --for jan

        order by ha.actualId                                         

        

        select    ha.brandId, sg.brandName, s.medicineName,                     

                --ha.empId, ha.hospitalId, ha.brandId, sg.brandName, ha.brandGroupId, BG.groupName, ha.skuId, s.medicineName,                     

                ROUND(sum(ha.rate* ha.qty), 2) as TotalSalesValue                 

        from TblHospitalactuals HA                              

        INNER JOIN tblCustomers C ON C.CustomerID = hA.hospitalId                              

        INNER JOIN tblBrandGroups BG ON BG.brandGroupId = HA.brandGroupId                              

        INNER join tblSkuGroup sg on sg.brandId = ha.brandId                             

        INNER JOIN tblSKUs s on s.medID = ha.skuId                      

        WHERE empId =  @KamId   AND HA.isDisabled = 0                 

        --AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)                       --for feb

         AND ActualEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)                       --for jan

        group by ha.brandId, sg.brandName, s.medicineName                         

    END          

SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ZBM_MarketInsights_LIST_FOR_APPROVAL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_ZBM_MarketInsights_LIST_FOR_APPROVAL 838       
--------------------------------------------            
-- CREATED BY: GURU SINGH            
-- CREATED DATE: 24-SEP-2022            
--------------------------------------------            
CREATE PROCEDURE [BSV_IVF].[USP_GET_ZBM_MarketInsights_LIST_FOR_APPROVAL]            
(        
    @KamId int       
)        
AS            
SET NOCOUNT on;           
        BEGIN         
       
    select accountName, CENTRENAME, DoctorName, CITY,        
            case HP.ZBMApproved       
                when 1 then 'Pending'       
                when 0 then 'Approved'       
                when 2 then 'Rejected'       
            end as statusText,       
            case HP.ZBMApproved       
                when 1 then 0       
                when 0 then 1       
                when 2 then 2       
            end as sortOrder, HP.*       
      
            from tblMarketInsights HP       
            INNER JOIN tblCustomers C ON C.CustomerID = hp.centreId       
            left outer JOIN tblAccount a on a.accountID = c.accountID       
    where 1 = 1       
     and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)        
   --  and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)        
    and empId =  @KamId    and HP.isApproved <> 1    
     order by sortOrder ASC       
       
        END       
SET NOCOUNT OFF;     
    
-- SELECT TOP 1 * FROM tblMarketInsights 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ZBM_MarketInsights_LIST_FOR_APPROVALv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- USP_GET_ZBM_MarketInsights_LIST_FOR_APPROVAL 838       

--------------------------------------------            

-- CREATED BY: GURU SINGH            

-- CREATED DATE: 24-SEP-2022            

--------------------------------------------            

CREATE PROCEDURE [BSV_IVF].[USP_GET_ZBM_MarketInsights_LIST_FOR_APPROVALv1]            

(        

    @KamId int       

)        

AS            

SET NOCOUNT on;           

        BEGIN         

       

    select accountName, CENTRENAME, DoctorName, CITY,        

            case HP.ZBMApproved       

                when 1 then 'Pending'       

                when 0 then 'Approved'       

                when 2 then 'Rejected'       

            end as statusText,       

            case HP.ZBMApproved       

                when 1 then 0       

                when 0 then 1       

                when 2 then 2       

            end as sortOrder, HP.*       

      

            from tblMarketInsights HP       

            INNER JOIN tblCustomers C ON C.CustomerID = hp.centreId       

            left outer JOIN tblAccount a on a.accountID = c.accountID       

    where 1 = 1       

   --  and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)        -- for feb

     and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)  -- for jan      

    and empId =  @KamId    and HP.isApproved <> 1    

     order by sortOrder ASC       

       

        END       

SET NOCOUNT OFF;     

    

-- SELECT TOP 1 * FROM tblMarketInsights 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ZBM_POTENTIAL_LIST_FOR_APPROVAL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_ZBM_POTENTIAL_LIST_FOR_APPROVAL 61       
--------------------------------------------            
-- CREATED BY: GURU SINGH            
-- CREATED DATE: 24-SEP-2022            
--------------------------------------------            
CREATE PROCEDURE [BSV_IVF].[USP_GET_ZBM_POTENTIAL_LIST_FOR_APPROVAL]            
(        
    @KamId int       
)        
AS            
SET NOCOUNT on;           
        BEGIN         
       
    select accountName, CENTRENAME, DoctorName, CITY,        
            case HP.ZBMApproved       
                when 1 then 'Pending'       
                when 0 then 'Approved'       
                when 2 then 'Rejected'       
            end as statusText,       
            case HP.ZBMApproved       
                when 1 then 0       
                when 0 then 1       
                when 2 then 2       
            end as sortOrder, HP.*       
      
            from tblhospitalsPotentials HP       
            INNER JOIN tblCustomers C ON C.CustomerID = hp.hospitalId       
            left OUTER JOIN tblAccount a on a.accountID = c.accountID       
    where 1 = 1       
    and PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)        
    -- and PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)        
    and empId =  @KamId    and HP.isApproved <> 1     
     order by sortOrder ASC       
       
        END       
SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ZBM_POTENTIAL_LIST_FOR_APPROVALv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_GET_ZBM_POTENTIAL_LIST_FOR_APPROVAL 61       

--------------------------------------------            

-- CREATED BY: GURU SINGH            

-- CREATED DATE: 24-SEP-2022            

--------------------------------------------            

CREATE PROCEDURE [BSV_IVF].[USP_GET_ZBM_POTENTIAL_LIST_FOR_APPROVALv1]            

(        

    @KamId int       

)        

AS            

SET NOCOUNT on;           

        BEGIN         

       

    select accountName, CENTRENAME, DoctorName, CITY,        

            case HP.ZBMApproved       

                when 1 then 'Pending'       

                when 0 then 'Approved'       

                when 2 then 'Rejected'       

            end as statusText,       

            case HP.ZBMApproved       

                when 1 then 0       

                when 0 then 1       

                when 2 then 2       

            end as sortOrder, HP.*       

      

            from tblhospitalsPotentials HP       

            INNER JOIN tblCustomers C ON C.CustomerID = hp.hospitalId       

            left OUTER JOIN tblAccount a on a.accountID = c.accountID       

    where 1 = 1       

    --and PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)        --for feb

    and PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)        --for jan

    and empId =  @KamId    and HP.isApproved <> 1     

     order by sortOrder ASC       

       

        END       

SET NOCOUNT OFF; 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ZBM_RATE_CONTRACT_LIST_FOR_APPROVAL]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
-- USP_GET_ZBM_RATE_CONTRACT_LIST_FOR_APPROVAL 63   
--------------------------------------------         
-- CREATED BY: GURU SINGH         
-- CREATED DATE: 24-SEP-2022         
--------------------------------------------      
CREATE PROCEDURE [BSV_IVF].[USP_GET_ZBM_RATE_CONTRACT_LIST_FOR_APPROVAL] 
( 
    @parentID int 
) 
as 
BEGIN 
    SELECT 
       --  cat.*, 987654,
        a.accountName, a.accountId as aid, 
        case 
              when cat.isApproved = 1 then 'Approval Pending' 
               when cat.isApproved = 0 then 'Approved' 
              when cat.expiryDate < getdate() then 'Expired' 
              when cat.accountID is null then 'No Contract' 
            end as RateContractStatus, 
        isNull(cat.accountID, 0) as CatAccountId, 
        (select count(*) 
        from TblContractDetails 
        where isdisabled = 0 and chainAccountTypeId = cat.accountID) as SKUDetails, 
        c.* 
    from tblCustomers C 
        INNER JOIN tblEmpHospitals eh ON EH.hospitalId = c.customerId 
        INNER JOIN tblHierarchy H ON EH.EmpID = H.EmpID 
        INNER JOIN tblaccount a on c.accountID = a.accountID 
        inner join tblchainAccountType cat on cat.customerAccountID = c.accountID and cat.isDisabled = 0 
    WHERE c.isdisabled = 0 and h.parentID = @parentID -- and cat.isapproved = 1 
    order by a.accountName ASC 
 
END 
  
 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_GET_ZBM_RATE_CONTRACT_LIST_FOR_APPROVALv1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

-- USP_GET_ZBM_RATE_CONTRACT_LIST_FOR_APPROVAL 63   

--------------------------------------------         

-- CREATED BY: GURU SINGH         

-- CREATED DATE: 24-SEP-2022         

--------------------------------------------      

CREATE PROCEDURE [BSV_IVF].[USP_GET_ZBM_RATE_CONTRACT_LIST_FOR_APPROVALv1] 

( 

    @parentID int 

) 

as 

BEGIN 

    SELECT 

       --  cat.*, 987654,

        a.accountName, a.accountId as aid, 

        case 

              when cat.isApproved = 1 then 'Approval Pending' 

               when cat.isApproved = 0 then 'Approved' 

              when cat.expiryDate < getdate() then 'Expired' 

              when cat.accountID is null then 'No Contract' 

            end as RateContractStatus, 

        isNull(cat.accountID, 0) as CatAccountId, 

        (select count(*) 

        from TblContractDetails 

        where isdisabled = 0 and chainAccountTypeId = cat.accountID) as SKUDetails, 

        c.* 

    from tblCustomers C 

        INNER JOIN tblEmpHospitals eh ON EH.hospitalId = c.customerId 

        INNER JOIN tblHierarchy H ON EH.EmpID = H.EmpID 

        INNER JOIN tblaccount a on c.accountID = a.accountID 

        inner join tblchainAccountType cat on cat.customerAccountID = c.accountID and cat.isDisabled = 0 

    WHERE c.isdisabled = 0 and h.parentID = @parentID -- and cat.isapproved = 1 

    order by a.accountName ASC 

 

END 

  

GO
/****** Object:  StoredProcedure [BSV_IVF].[usp_insert_CUSTOMER_contractRate]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [BSV_IVF].[usp_insert_CUSTOMER_contractRate] (
    @chainAccountTypeId int,
    @brandId int,
    @brandGroupId int,
    @medId int,
    @price FLOAT
)
AS
    BEGIN
            UPDATE TblContractDetails set isdisabled = 1
            WHERE  
                chainAccountTypeId = @chainAccountTypeId and
                brandId = @brandId  and
                brandGroupId = @brandGroupId  and
                medId = @medId

            INSERT INTO TblContractDetails (chainAccountTypeId, brandId, 
                    brandGroupId, medId, price, isDisabled)
                    VALUES (@chainAccountTypeId, @brandId, 
                    @brandGroupId, @medId, @price, 0) 
    END




-- select * from TblContractDetails

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_IUI_CYCLE_CATEGORY]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_IUI_CYCLE_CATEGORY_v1 64, 1, 2023  
------------------------------------  
-- crated by : guru singh  
-- crated date: 15-mar-2023  
------------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_IUI_CYCLE_CATEGORY]   
(  
    @empId int = null,  
    @month int = NULL,  
    @Year int = null  
)  
AS    
    set nocount on;  
        BEGIN  
        if @month is NULL  
            BEGIN  
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  
            END  
        if @Year is NULL  
            BEGIN  
            set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  
            END  
CREATE TABLE #empHierarchy   
(   
    levels smallInt,   
    EmpID INT,   
    ParentId int   
)   
;WITH   
    RecursiveCte   
    AS   
    (   
        SELECT 1 as Level, H1.EmpID, H1.ParentId   
            FROM tblHierarchy H1   
            WHERE (@empid is null or ParentID = @empid)   
        UNION ALL   
        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId   
            FROM tblHierarchy H2   
                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID   
    )   
            insert into #empHierarchy   
                (levels, EmpID, ParentId )   
            SELECT Level, EmpID, ParentId   
            FROM RecursiveCte r   
            ;   
             insert into #empHierarchy   
                (levels, EmpID, ParentId )   
            VALUEs (0, @empId, -1)  
        declare @addedFor DATE  
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))   
        select case  
                when IUICycle = 0 then 'Nill'  
                WHEN IUICycle BETWEEN 1 AND 10 THEN '1 to 10 Cycle'  
                WHEN IUICycle BETWEEN 11 AND 20 THEN '11 to 20 Cycle'  
                WHEN IUICycle BETWEEN 21 AND 30 THEN '21 to 30 Cycle'  
                WHEN IUICycle BETWEEN 31 AND 400 THEN '31 to 40 Cycle'  
                else 'F - more then 40 Cycle'  
            end as Cycle,  
			case  
                when IUICycle = 0 then 0  
                WHEN IUICycle BETWEEN 1 AND 10 THEN 1  
                WHEN IUICycle BETWEEN 11 AND 20 THEN 2  
                WHEN IUICycle BETWEEN 21 AND 30 THEN 3  
                WHEN IUICycle BETWEEN 31 AND 400 THEN 4  
                else 5  
            end as CycleSort,  
			 hospitalId  
        from tblhospitalsPotentials  
        where PotentialEnteredFor = @addedFor  
        and empId in (select empId from #empHierarchy)  
		order by CycleSort asc  
          drop table #empHierarchy   
        END  
    set nocount off;  
  
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_IUI_CYCLE_CATEGORY_v1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
-- crated by : guru singh
-- crated date: 15-mar-2023
------------------------------------
CREATE PROCEDURE [BSV_IVF].[USP_IUI_CYCLE_CATEGORY_v1] 
(
    @empId int = null,
    @month int = NULL,
    @Year int = null
)
AS  
    set nocount on;
        BEGIN
        if @month is NULL
            BEGIN
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))
            END
        if @Year is NULL
            BEGIN
            set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))
            END

CREATE TABLE #empHierarchy 
( 
    levels smallInt, 
    EmpID INT, 
    ParentId int 
) 
             
;WITH 
    RecursiveCte 
    AS 
    ( 
        SELECT 1 as Level, H1.EmpID, H1.ParentId 
            FROM tblHierarchy H1 
            WHERE (@empid is null or ParentID = @empid) 
        UNION ALL 
        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId 
            FROM tblHierarchy H2 
                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID 
    ) 
            insert into #empHierarchy 
                (levels, EmpID, ParentId ) 
            SELECT Level, EmpID, ParentId 
            FROM RecursiveCte r 
            ; 
             insert into #empHierarchy 
                (levels, EmpID, ParentId ) 
            VALUEs (0, @empId, -1)

        declare @addedFor DATE
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1)) 
        select case
                when IUICycle = 0 then 'A'
                WHEN IUICycle BETWEEN 1 AND 10 THEN 'B'
                WHEN IUICycle BETWEEN 11 AND 20 THEN 'C'
                WHEN IUICycle BETWEEN 21 AND 30 THEN 'D'
                WHEN IUICycle BETWEEN 31 AND 40 THEN 'E'
                else 'F'
            end as Cycle, hospitalId
        from tblhospitalsPotentials
        where PotentialEnteredFor = @addedFor
        and empId in (select empId from #empHierarchy)


          drop table #empHierarchy 
        END
    set nocount off;




GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_IVF_CYCLE_CATEGORY]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 -- USP_IVF_CYCLE_CATEGORY 64, 1, 2023  
 ------------------------------------  
 -- crated by : guru singh  
 -- crated date: 15-mar-2023  
 ------------------------------------  
 CREATE PROCEDURE [BSV_IVF].[USP_IVF_CYCLE_CATEGORY]   
 (  
     @empId int = null,  
     @month int = NULL,  
    @Year int = null  
 )  
 AS    
     set nocount on;  
        BEGIN  
         if @month is NULL  
             BEGIN  
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  
             END  
        if @Year is NULL  
  
            BEGIN  
             set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  
              END  
  
 CREATE TABLE #empHierarchy   
 (   
  
    levels smallInt,   
     EmpID INT,   
     ParentId int   
)   
;WITH   
    RecursiveCte   
    AS   
    (   
        SELECT 1 as Level, H1.EmpID, H1.ParentId   
            FROM tblHierarchy H1   
            WHERE (@empid is null or ParentID = @empid)   
        UNION ALL   
        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId   
            FROM tblHierarchy H2   
                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID   
    )   
            insert into #empHierarchy   
                (levels, EmpID, ParentId )   
            SELECT Level, EmpID, ParentId   
            FROM RecursiveCte r   
            ;   
             insert into #empHierarchy   
                (levels, EmpID, ParentId )   
            VALUEs (0, @empId, -1)  
        declare @addedFor DATE  
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))   
        select case  
                when IvFCycle = 0 then 'Nill'  
                WHEN IvFCycle BETWEEN 1 AND 10 THEN '1 to 10 Cycle'  
                WHEN IvFCycle BETWEEN 11 AND 20 THEN '11 to 20 Cycle'  
                WHEN IvFCycle BETWEEN 21 AND 30 THEN '21 to 30 Cycle'  
                WHEN IvFCycle BETWEEN 31 AND 400 THEN '31 to 40 Cycle'  
                else 'F more than 40 Cycle'  
            end as Cycle, hospitalId, 
            case  
                when IvFCycle = 0 then 0  
                WHEN IvFCycle BETWEEN 1 AND 10 THEN 1  
                WHEN IvFCycle BETWEEN 11 AND 20 THEN 2  
                WHEN IvFCycle BETWEEN 21 AND 30 THEN 3  
                WHEN IvFCycle BETWEEN 31 AND 400 THEN 4  
                else 5  
            end as CycleSort 
  
        from tblhospitalsPotentials  
        where PotentialEnteredFor = @addedFor  
        and empId in (select empId from #empHierarchy)  
		order by CycleSort asc  
          drop table #empHierarchy   
        END  
    set nocount off;  
GO
/****** Object:  StoredProcedure [BSV_IVF].[usp_list_competitor_SKUs]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [BSV_IVF].[usp_list_competitor_SKUs]
as
set NOCOUNT on;
    select sg.brandId, sg.brandName, bcs.competitorId, bcs.name from tblBrandcompetitorSKUs bcs
    inner join tblSkuGroup sg on bcs.brandId = sg.brandId
    where bcs.isdisabled = 0
    order by sg.brandId asc
set NOCOUNT off;
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_LIST_MARKET_INSIGHT]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------
-- CREATED BY: GURU SINGH
-- CREATED DATE: 16-FEB-2023
-------------------------------------------
CREATE PROCEDURE [BSV_IVF].[USP_LIST_MARKET_INSIGHT]
AS
    SET NOCOUNT ON;
        SELECT * FROM tblMarketInsights ORDER BY insightId DESC
    SET NOCOUNT OFF;

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_LIST_MARKET_INSIGHT_BY_INSIGHTID]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_LIST_MARKET_INSIGHT_BY_INSIGHTID 1046, 967
-------------------------------------------  
-- CREATED BY: GURU SINGH  
-- CREATED DATE: 16-FEB-2023  
-------------------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_LIST_MARKET_INSIGHT_BY_INSIGHTID]  
(  
    @insightId INT = NULL,
    @centerId int = null  
)  
AS  
    SET NOCOUNT ON;  
   

            SELECT * FROM tblMarketInsights WHERE insightId = isnull(@insightId,0)   
            SELECT top 1 * FROM TblHospitalsPotentials WHERE hospitalId = @centerID 
                        --and empID = @empID 
                    order by potentialId DESC 
 
    SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_REPORT_BRANDS_ANALYSIS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_REPORT_BRANDS_ANALYSIS null, NULL, NULL
------------------------------------   
-- crated by : guru singh   
-- crated date: 15-mar-2023   
------------------------------------   
CREATE PROCEDURE [BSV_IVF].[USP_REPORT_BRANDS_ANALYSIS]   
(   
    @empId int = null,  
    @fromDate date = null,
    @toDate date  = null
)   
AS     
set nocount on;     
    BEGIN
        IF @fromDate IS NULL    
        BEGIN
            SET @fromDate = '1-JAN-2023'
        END
        IF @toDate IS NULL    
        BEGIN
            SET @toDate = '31-DEC-2029'
        END


            CREATE TABLE #empHierarchy (levels smallInt, EmpID INT, ParentId int )
            ;WITH    
                RecursiveCte    
                AS    
                (    
                    SELECT 1 as Level, H1.EmpID, H1.ParentId    
                        FROM tblHierarchy H1    
                        WHERE (@empid is null or ParentID = @empid)    
                    UNION ALL    
                    SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId    
                        FROM tblHierarchy H2    
                            INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID    
                )    
                        insert into #empHierarchy    
                            (levels, EmpID, ParentId )    
                        SELECT Level, EmpID, ParentId    
                        FROM RecursiveCte r    
                        ;    
                        insert into #empHierarchy    
                            (levels, EmpID, ParentId )    
                        VALUEs (0, @empId, -1)   

            -- select count(*) from #empHierarchy  

            -- USP_REPORT_BRANDS_ANALYSIS null, '1-jan-2023', '31-Mar-2023'
            select ha.brandId, sg.groupname as name,  sum(qty) as sumTotalofQty
            -- count(*) as CNT
            from TblHospitalactuals ha  
            INNER JOIN tblBrandGroups sg on sg.brandGroupId = ha.brandGroupId  
            where ha.isApproved = 0  and ha.isDisabled = 0  
            and empId in (select empId from #empHierarchy)   
            and (ActualEnteredFor BETWEEN @fromDate AND @toDate)
            GROUP BY ha.brandId, ha.brandGroupId, sg.groupname 
            order by ha.brandId asc



            select ca.brandId, bcs.name, sum(businessValue) as TotalBusinessValue from tblCompetitions ca 
            inner join tblbrandCompetitorSkus bcs 
                on bcs.brandId = ca.brandId and bcs.competitorId = ca.CompetitionSkuId
            where ca.isApproved = 0  -- and ca.brandId  in (1) and bcs.competitorId in (2, 4, 19)
            and empId in (select empId from #empHierarchy)   
            and (competitionAddedFor BETWEEN @fromDate AND @toDate)
            GROUP by ca.brandId, bcs.name
            order by ca.brandId asc    

         
        

            drop table #empHierarchy    
    END   
set nocount off;   

-- select * from tblBrandGroups where brandId = 6
-- select * from tblBrandcompetitorSKUs where brandId = 6

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_REPORT_BRANDS_CONSUMPTION]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_REPORT_BRANDS_CONSUMPTION null, NULL, NULL 
------------------------------------    
-- crated by : guru singh    
-- crated date: 15-mar-2023    
------------------------------------    
CREATE PROCEDURE [BSV_IVF].[USP_REPORT_BRANDS_CONSUMPTION]
(    
    -- @empId int = null,   
    -- @fromDate date = null, 
    -- @toDate date  = null 

     @empId int = null, 
     @month int = NULL, 
    @Year int = null 
)    
AS      
set nocount on;      
    BEGIN 
        -- IF @fromDate IS NULL     
        -- BEGIN 
        --     SET @fromDate = '1-JAN-2023' 
        -- END 
        -- IF @toDate IS NULL     
        -- BEGIN 
        --     SET @toDate = '31-DEC-2023' 
        -- END 
   
         if @month is NULL 
             BEGIN 
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)) 
             END 
        if @Year is NULL 
 
            BEGIN 
             set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)) 
              END 
 
 
            CREATE TABLE #empHierarchy (levels smallInt, EmpID INT, ParentId int ) 
            ;WITH     
                RecursiveCte     
                AS     
                (     
                    SELECT 1 as Level, H1.EmpID, H1.ParentId     
                        FROM tblHierarchy H1     
                        WHERE (@empid is null or ParentID = @empid)     
                    UNION ALL     
                    SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId     
                        FROM tblHierarchy H2     
                            INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID     
                )     
                        insert into #empHierarchy     
                            (levels, EmpID, ParentId )     
                        SELECT Level, EmpID, ParentId     
                        FROM RecursiveCte r     
                        ;     
                        insert into #empHierarchy     
                            (levels, EmpID, ParentId )     
                        VALUEs (0, @empId, -1)    
 



 declare @addedFor DATE 
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))  
    SELECT  
        bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,    
        bsv_ivf.getMyRBMInfo(e.empid) AS RBM,    
        e.firstName as KamName, e.Designation,     
        c.CENTRENAME as centreName,  c.DoctorName,  
        HP.IVFCycle as 'IVF Fresh stimulated Cycles'
        --, hp.hospitalId,
        --c.customerId
        , c.CENTRENAME, c.DoctorName,
         hp.empId
        ,(HP.IVFCycle * 10) as 'Foligraf'
        ,(HP.IVFCycle * 10) as 'Humog'
        ,(HP.IVFCycle * 5) as 'Asporelix'
        ,(HP.IVFCycle * 1) as 'R-Hucog'
        ,(HP.IVFCycle * 1) as 'Agotrig'
        ,(HP.IVFCycle * 30) as 'Midydrogen'
        FROM TblHospitalsPotentials hp
        INNER join tblCustomers c on c.customerID = hp.hospitalId
        INNER join tblEmployees e on e.empId = hp.empId
        WHERE  hp.isActive = 0 
        and  hp.isApproved = 0
       --  and (PotentialEnteredFor BETWEEN @fromDate AND @toDate) 
        and PotentialEnteredFor = @addedFor 
        and hp.empId in (select empId from #empHierarchy)   
         order by hospitalId ASC 
      
      
         
            drop table #empHierarchy     
    END    
set nocount off;    
    
 
--    SELECT * FROM TBLEMPLOYEES WHERE DESIGNATION = 'ADMIN'
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_REPORT_BRANDS_FOLIGRAF_ANALYSIS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_REPORT_BRANDS_FOLIGRAF_ANALYSIS null, NULL, NULL
------------------------------------   
-- crated by : guru singh   
-- crated date: 15-mar-2023   
------------------------------------   
CREATE PROCEDURE [BSV_IVF].[USP_REPORT_BRANDS_FOLIGRAF_ANALYSIS]   
(   
    @empId int = null,  
    @fromDate date = null,
    @toDate date  = null
)   
AS     
set nocount on;     
    BEGIN
        IF @fromDate IS NULL    
        BEGIN
            SET @fromDate = '1-JAN-2023'
        END
        IF @toDate IS NULL    
        BEGIN
            SET @toDate = '31-DEC-2023'
        END


            CREATE TABLE #empHierarchy (levels smallInt, EmpID INT, ParentId int )
            ;WITH    
                RecursiveCte    
                AS    
                (    
                    SELECT 1 as Level, H1.EmpID, H1.ParentId    
                        FROM tblHierarchy H1    
                        WHERE (@empid is null or ParentID = @empid)    
                    UNION ALL    
                    SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId    
                        FROM tblHierarchy H2    
                            INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID    
                )    
                        insert into #empHierarchy    
                            (levels, EmpID, ParentId )    
                        SELECT Level, EmpID, ParentId    
                        FROM RecursiveCte r    
                        ;    
                        insert into #empHierarchy    
                            (levels, EmpID, ParentId )    
                        VALUEs (0, @empId, -1)   

            -- select count(*) from #empHierarchy  

            -- USP_REPORT_BRANDS_FOLIGRAF_ANALYSIS null, '1-jan-2023', '31-Mar-2023'
            select sg.groupname as name,  sum(qty) as sumTotalofQty
            -- count(*) as CNT
            from TblHospitalactuals ha  
            INNER JOIN tblBrandGroups sg on sg.brandGroupId = ha.brandGroupId  
            where ha.isApproved = 0  and ha.isDisabled = 0  
            and ha.brandId  = 1 and ha.brandGroupId in (1, 2)
            and empId in (select empId from #empHierarchy)   
            and (ActualEnteredFor BETWEEN @fromDate AND @toDate)
            GROUP BY ha.brandGroupId, sg.groupname 



            select bcs.name, sum(businessValue) as TotalBusinessValue from tblCompetitions ca 
            inner join tblbrandCompetitorSkus bcs 
                on bcs.brandId = ca.brandId and bcs.competitorId = ca.CompetitionSkuId
            where ca.isApproved = 0  and ca.brandId  in (1) and bcs.competitorId in (2, 4, 19)
            and empId in (select empId from #empHierarchy)   
            and (competitionAddedFor BETWEEN @fromDate AND @toDate)
            GROUP by bcs.name
            order by TotalBusinessValue desc    

            select bcs.name, sum(businessValue) as TotalBusinessValue from tblCompetitions ca 
            inner join tblbrandCompetitorSkus bcs 
                on bcs.brandId = ca.brandId and bcs.competitorId = ca.CompetitionSkuId
            where ca.isApproved = 0  and ca.brandId  in (1) and bcs.competitorId in (1, 3, 5)
            and empId in (select empId from #empHierarchy)   
            and (competitionAddedFor BETWEEN @fromDate AND @toDate)
            GROUP by bcs.name
            order by TotalBusinessValue desc    
        

            drop table #empHierarchy    
    END   
set nocount off;   

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_REPORT_BRANDS_VENNDIAGRAM]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_REPORT_BRANDS_VENNDIAGRAM null, NULL, NULL
------------------------------------   
-- crated by : guru singh   
-- crated date: 15-mar-2023   
------------------------------------   
CREATE PROCEDURE [BSV_IVF].[USP_REPORT_BRANDS_VENNDIAGRAM]   
(   
    @empId int = null,  
    @fromDate date = null,
    @toDate date  = null
)   
AS     
set nocount on;     
    BEGIN
        IF @fromDate IS NULL    
        BEGIN
            SET @fromDate = '1-JAN-2023'
        END
        IF @toDate IS NULL    
        BEGIN
            SET @toDate = '31-DEC-2023'
        END


            CREATE TABLE #empHierarchy (levels smallInt, EmpID INT, ParentId int )
            ;WITH    
                RecursiveCte    
                AS    
                (    
                    SELECT 1 as Level, H1.EmpID, H1.ParentId    
                        FROM tblHierarchy H1    
                        WHERE (@empid is null or ParentID = @empid)    
                    UNION ALL    
                    SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId    
                        FROM tblHierarchy H2    
                            INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID    
                )    
                        insert into #empHierarchy    
                            (levels, EmpID, ParentId )    
                        SELECT Level, EmpID, ParentId    
                        FROM RecursiveCte r    
                        ;    
                        insert into #empHierarchy    
                            (levels, EmpID, ParentId )    
                        VALUEs (0, @empId, -1)   

            -- select count(*) from #empHierarchy  
            select sg.brandName, count(*) as CNT
            from TblHospitalactuals ha  
            INNER JOIN tblSkuGroup sg on sg.brandID = ha.brandId  
            where ha.isApproved = 0  and ha.isDisabled = 0  
            and empId in (select empId from #empHierarchy)   
            and (ActualEnteredFor BETWEEN @fromDate AND @toDate)
            GROUP BY sg.brandName

-- USP_REPORT_BRANDS_VENNDIAGRAM null, NULL, NULL

            select sg.brandName, hospitalId
            from TblHospitalactuals ha  
            INNER JOIN tblSkuGroup sg on sg.brandID = ha.brandId  
            where ha.isApproved = 0  and ha.isDisabled = 0  
            and empId in (select empId from #empHierarchy)   
            and (ActualEnteredFor BETWEEN @fromDate AND @toDate)
            -- OR (ActualEnteredFor IS NULL AND @fromDate IS NULL AND @toDate IS NULL)
            -- OR (ActualEnteredFor >= @fromDate AND @toDate IS NULL)
            -- OR (ActualEnteredFor <= @toDate AND @fromDate IS NULL)
            order by hospitalId ASC
        
            drop table #empHierarchy    
    END   
set nocount off;   
   

--    SELECT * FROM TBLEMPLOYEES WHERE DESIGNATION = 'ADMIN'
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_REPORT_HOSPITALCOUNT_BRANDWISE]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_REPORT_HospitalCount_brandWise null, 1, 2023  
------------------------------------  
-- crated by : guru singh  
-- crated date: 15-mar-2023  
------------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_REPORT_HOSPITALCOUNT_BRANDWISE]  
(  
    @empId int = null,  
    @month int = NULL,  
    @Year int = null  
)  
AS    
    set nocount on;  
        BEGIN  
        if @month is NULL  
            BEGIN  
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  
            END  
        if @Year is NULL  
            BEGIN  
            set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  
            END  
  
CREATE TABLE #empHierarchy   
(   
    levels smallInt,   
    EmpID INT,   
    ParentId int   
)   
               
;WITH   
    RecursiveCte   
    AS   
    (   
        SELECT 1 as Level, H1.EmpID, H1.ParentId   
            FROM tblHierarchy H1   
            WHERE (@empid is null or ParentID = @empid)   
        UNION ALL   
        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId   
            FROM tblHierarchy H2   
                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID   
    )   
            insert into #empHierarchy   
                (levels, EmpID, ParentId )   
            SELECT Level, EmpID, ParentId   
            FROM RecursiveCte r   
            ;   
             insert into #empHierarchy   
                (levels, EmpID, ParentId )   
            VALUEs (0, @empId, -1)  
  
 
 -- select count(*) from #empHierarchy 
 
        declare @addedFor DATE  
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))   
       
 
         
            select * 
            from 
            ( 
            select ha.brandId, sg.brandName from TblHospitalactuals ha 
            INNER JOIN tblSkuGroup sg on sg.brandID = ha.brandId 
            where ha.isApproved = 0  and ha.isDisabled = 0 
            and ActualEnteredFor = @addedFor  
            and empId in (select empId from #empHierarchy)  
            ) d 
            pivot 
            ( 
            count(d.brandId) 
            for brandName in (FOLIGRAF,HUMOG,ASPORELIX,[R-HUCOG],FOLICULIN,AGOTRIG,MIDYDROGEN,SPRIMEO) 
            ) piv; 
 
 
  

        SELECT COUNT(*) as totalHospital 
        FROM tblCustomers c 
            INNER JOIN  tblEmpHospitals eh on eh.hospitalId = c.customerId
            INNER JOIN tblSpecialtyType st on st.specialtyId = c.specialtyId and st.specialtyId in (2) 
        WHERE 
            c.isdisabled = 0 and eh.empID in (select EmpID from #empHierarchy )
  

          drop table #empHierarchy   
        END  
    set nocount off;  
  
  
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_REPORT_MARKET_INSIGHT]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_REPORT_MARKET_INSIGHT null, 1, 2023   
------------------------------------   
-- crated by : guru singh   
-- crated date: 15-mar-2023   
------------------------------------   
CREATE PROCEDURE [BSV_IVF].[USP_REPORT_MARKET_INSIGHT]   
(   
    @empId int = null,   
    @month int = NULL,   
    @Year int = null   
)   
AS     
    set nocount on;   
        BEGIN   
        if @month is NULL   
            BEGIN   
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))   
            END   
        if @Year is NULL   
            BEGIN   
            set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))   
            END   
   
CREATE TABLE #empHierarchy    
(    
    levels smallInt,    
    EmpID INT,    
    ParentId int    
)    
                
;WITH    
    RecursiveCte    
    AS    
    (    
        SELECT 1 as Level, H1.EmpID, H1.ParentId    
            FROM tblHierarchy H1    
            WHERE (@empid is null or ParentID = @empid)    
        UNION ALL    
        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId    
            FROM tblHierarchy H2    
                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID    
    )    
            insert into #empHierarchy    
                (levels, EmpID, ParentId )    
            SELECT Level, EmpID, ParentId    
            FROM RecursiveCte r    
            ;    
             insert into #empHierarchy    
                (levels, EmpID, ParentId )    
            VALUEs (0, @empId, -1)   
   
  
    -- SELECT count(*) from #empHierarchy  
  
        declare @addedFor DATE   
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))    
        
  
   
            SELECT  
                SUM(TRY_CAST(answerFourRHCG AS INT)) as RHCG,  
                SUM(TRY_CAST(answerFourUHCG AS INT)) as UHCG,  
                SUM(TRY_CAST(answerFourAgonistL AS INT)) as AgonistL,  
                SUM(TRY_CAST(answerFourAgonistT AS INT)) as AgonistT,  
                SUM(TRY_CAST(answerFourRHCGTriptorelin AS INT)) as RHCGTriptorelin,  
                SUM(TRY_CAST(answerFourRHCGLeuprolide AS INT)) as RHCGLeuprolide 
            FROM tblMarketInsights 
            WHERE  addedFor = @addedFor  -- 1388 
            AND isApproved = 0 -- 1025 
            AND isActive = 0 -- 991 
            AND empId IN (SELECT empId FROM #empHierarchy)   
 
 
             
            SELECT  
                SUM(TRY_CAST(answerProgesterone AS INT)) as Progesterone, 
                SUM(TRY_CAST(answerFiveDydrogesterone AS INT)) as Dydrogesterone, 
                SUM(TRY_CAST(answerFiveCombination AS INT)) as Combination 
            FROM tblMarketInsights 
            WHERE  addedFor = @addedFor  -- 1388 
            AND isApproved = 0 -- 1025 
            AND isActive = 0 -- 991 
            AND empId IN (SELECT empId FROM #empHierarchy)   
 
 
 
            SELECT  
               SUM(TRY_CAST(answerThreeHMG AS INT)) as [R-FSH], 
                SUM(TRY_CAST(answerThreeRFSH AS INT)) as HMG 
            FROM tblMarketInsights 
            WHERE  addedFor = @addedFor  -- 1388 
            AND isApproved = 0 -- 1025 
            AND isActive = 0 -- 991 
            AND empId IN (SELECT empId FROM #empHierarchy)   
  
   
 
            SELECT  
                COUNT(CASE WHEN answerOne = 0 THEN 1 END) AS Yes_obstetrics, 
                COUNT(CASE WHEN answerOne = 1 THEN 1 END) AS NO_obstetrics 
            FROM tblMarketInsights 
            WHERE  addedFor = @addedFor  -- 1388 
            AND isApproved = 0 -- 1025 
            AND isActive = 0 -- 991 
            AND empId IN (SELECT empId FROM #empHierarchy)   
 
 
    
   
    SELECT  
 HP.IVFCycle , 
TRY_CAST(answerThreeRFSH AS DECIMAL(5, 2) ) AS answerThreeRFSH, 
TRY_CAST(IVFCycle * (TRY_CAST(answerThreeRFSH AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [RFS CONSUMPTION] , 
--ROUND(TRY_CAST(IVFCycle * (TRY_CAST(answerThreeRFSH AS DECIMAL )/100) AS DECIMAL(5, 2)), 0) AS [RFS CONSUMPTION ROUNDOFF] , 
  
TRY_CAST(answerThreeHMG AS DECIMAL ) AS answerThreeHMG  ,
TRY_CAST(IVFCycle * (TRY_CAST(answerThreeHMG AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [HMG CONSUMPTION] , 
-- ROUND(TRY_CAST(IVFCycle * (TRY_CAST(answerThreeHMG AS DECIMAL )/100) AS DECIMAL(5, 2)), 0) AS [HMG CONSUMPTION ROUNDOFF] 

MI.answerProgesterone,
TRY_CAST(IVFCycle * (TRY_CAST(answerProgesterone AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Progesterone CONSUMPTION],

MI.answerFiveDydrogesterone,
TRY_CAST(IVFCycle * (TRY_CAST(answerFiveDydrogesterone AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Dydrogesterone CONSUMPTION],

MI.answerFiveCombination,
TRY_CAST(IVFCycle * (TRY_CAST(answerFiveCombination AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Progesretone+Dydrogesterone CONSUMPTION],

answerFourRHCG,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourRHCG AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [R-HCG CONSUMPTION],
answerFourUHCG,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourUHCG AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [U-HCG CONSUMPTION],
answerFourAgonistL,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourAgonistL AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Only Agonist-Leuprolide CONSUMPTION],
answerFourAgonistT,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourAgonistT AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Only Agonist-Triptorelin CONSUMPTION],
answerFourRHCGTriptorelin,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourRHCGTriptorelin AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Dual Trigger (R-HCG + Triptorelin) CONSUMPTION],
answerFourRHCGLeuprolide,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourRHCGLeuprolide AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Dual Trigger (R-HCG + Leuprolide) CONSUMPTION]




        FROM tblMarketInsights MI
        INNER JOIN TblHospitalsPotentials HP ON HP.HOSPITALID = MI.CENTREID
        WHERE  
        MI.addedFor = @addedFor 
        AND HP.PotentialEnteredFor = @addedFor  
        AND MI.isApproved = 0  
        AND MI.isActive = 0 
        AND MI.empId IN (SELECT empId FROM #empHierarchy) 

        
 
          drop table #empHierarchy    
        END   
    set nocount off;   
   
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_REPORT_POTENTIALS_V1]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_REPORT_Potentials_v1 null, 1, 2024  
------------------------------------  
-- crated by : guru singh  
-- crated date: 15-mar-2023  
------------------------------------  
CREATE PROCEDURE [BSV_IVF].[USP_REPORT_POTENTIALS_V1]  
(  
    @empId int = null,  
    @month int = NULL,  
    @Year int = null  
)  
AS    
    set nocount on;  
        BEGIN  
        if @month is NULL  
            BEGIN  
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  
            END  
        if @Year is NULL  
            BEGIN  
            set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  
            END  
  
CREATE TABLE #empHierarchy   
(   
    levels smallInt,   
    EmpID INT,   
    ParentId int   
)   
               
;WITH   
    RecursiveCte   
    AS   
    (   
        SELECT 1 as Level, H1.EmpID, H1.ParentId   
            FROM tblHierarchy H1   
            WHERE (@empid is null or ParentID = @empid)   
        UNION ALL   
        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId   
            FROM tblHierarchy H2   
                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID   
    )   
            insert into #empHierarchy   
                (levels, EmpID, ParentId )   
            SELECT Level, EmpID, ParentId   
            FROM RecursiveCte r   
            ;   
             insert into #empHierarchy   
                (levels, EmpID, ParentId )   
            VALUEs (0, @empId, -1)  
  
 
    -- SELECT count(*) from #empHierarchy 
 
        declare @addedFor DATE  
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))   
       
 
  
            
 
  

            -- SELECT 
            --     COUNT(CASE WHEN answerOne = 0 THEN 1 END) AS Yes_obstetrics,
            --     COUNT(CASE WHEN answerOne = 1 THEN 1 END) AS NO_obstetrics
            -- FROM tblMarketInsights
            -- WHERE  addedFor = @addedFor  -- 1388
            -- AND isApproved = 0 -- 1025
            -- AND isActive = 0 -- 991
            -- AND empId IN (SELECT empId FROM #empHierarchy)  



            SELECT 
                SUM(TRY_CAST(DonorCycles AS INT)) as DonorCycles, 
                SUM(TRY_CAST(SelftCycle AS INT)) as SelfCycle
            FROM TblHospitalsPotentials
            WHERE  1 =1
            AND PotentialEnteredFor = @addedFor  -- 1388
            AND isApproved = 0 -- 1025
            AND isActive = 0 -- 991
            AND empId IN (SELECT empId FROM #empHierarchy) 


            
            SELECT 
                SUM(TRY_CAST(AgonistCycles AS INT)) as AgonistCycles, 
                SUM(TRY_CAST(Antagonistcycles AS INT)) as Antagonistcycles
            FROM TblHospitalsPotentials
            WHERE  1 =1
            AND PotentialEnteredFor = @addedFor  -- 1388
            AND isApproved = 0 -- 1025
            AND isActive = 0 -- 991
            AND empId IN (SELECT empId FROM #empHierarchy) 




   
  
  

          drop table #empHierarchy   
        END  
    set nocount off;  
  
  
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_REPORT_TOP_15_ACCOUNTS]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- USP_REPORT_TOP_15_ACCOUNTS null, 1, 2023  

------------------------------------  

-- crated by : guru singh  

-- crated date: 15-mar-2023  

------------------------------------  

CREATE PROCEDURE [BSV_IVF].[USP_REPORT_TOP_15_ACCOUNTS]  

(  

    @empId int = null,  

    @month int = NULL,  

    @Year int = null  

)  

AS    

    set nocount on;  

        BEGIN  

        if @month is NULL  

            BEGIN  

            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  

            END  

        if @Year is NULL  

            BEGIN  

            set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))  

            END  

  

CREATE TABLE #empHierarchy   

(   

    levels smallInt,   

    EmpID INT,   

    ParentId int   

)   

               

;WITH   

    RecursiveCte   

    AS   

    (   

        SELECT 1 as Level, H1.EmpID, H1.ParentId   

            FROM tblHierarchy H1   

            WHERE (@empid is null or ParentID = @empid)   

        UNION ALL   

        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId   

            FROM tblHierarchy H2   

                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID   

    )   

            insert into #empHierarchy   

                (levels, EmpID, ParentId )   

            SELECT Level, EmpID, ParentId   

            FROM RecursiveCte r   

            ;   

             insert into #empHierarchy   

                (levels, EmpID, ParentId )   

            VALUEs (0, @empId, -1)  

  

 

 -- select count(*) from #empHierarchy 

 

        declare @addedFor DATE  

        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))   

       

 

         

            select top 15 hospitalId, c.CENTRENAME, 

                a.accountName, c.DoctorName, c.City, s.StateName,

                sum(qty) as QtyOrdered



            from tblhospitalActuals ha

            inner join tblCustomers c on c.customerId = ha.hospitalId

            INNER join tblAccount a on a.accountID = c.accountID

            inner join tblState s on s.stateID = c.StateID

            where ha.isApproved = 0 and ha.isDisabled = 0

            and actualenteredFor = @addedFor

            and empId in (select empId from #empHierarchy) 

            group by hospitalId , c.CENTRENAME, 

            a.accountName, c.DoctorName, c.City, s.StateName

            order by QtyOrdered desc



  

  

          drop table #empHierarchy   

        END  

    set nocount off;  

  

GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_VALIDATE_TEAM_PROGRESS_REPORT]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- USP_VALIDATE_TEAM_PROGRESS_REPORT  64
 -----------------------------------------
 -- CREATED BY: GURU SINGH
 -- CREATED DATE: 2-APR-2023
 -----------------------------------------
 CREATE PROCEDURE [BSV_IVF].[USP_VALIDATE_TEAM_PROGRESS_REPORT]
 (
      @empId int = null,   
    @month int = NULL,   
    @Year int = null  
 )
 AS     
    -- SET NOCOUNT ON;   
        BEGIN  
            if @month is NULL   
                BEGIN   
                set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))   
                END   
            if @Year is NULL   
                BEGIN   
                set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0))   
                END   

            
            CREATE TABLE #empHierarchy    
            (    
                levels smallInt,    
                EmpID INT,    
                ParentId int    
            )    
                
            ;WITH    
                RecursiveCte    
                AS    
                (    
                    SELECT 1 as Level, H1.EmpID, H1.ParentId    
                        FROM tblHierarchy H1    
                        WHERE (@empid is null or ParentID = @empid)    
                    UNION ALL    
                    SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId    
                        FROM tblHierarchy H2    
                            INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID    
                )    

            insert into #empHierarchy    
                (levels, EmpID, ParentId )    
            SELECT Level, EmpID, ParentId    
            FROM RecursiveCte r    
            ;    
             insert into #empHierarchy    
                (levels, EmpID, ParentId )    
            VALUEs (0, @empId, -1)   
   
  
            -- SELECT count(*) from #empHierarchy  
  
            declare @addedFor DATE   
            set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1)) 

            select e.empid,
            bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,   bsv_ivf.getMyRBMInfo(e.empid) AS RBM,    e.FIRSTname, e.designation, 
            (select count(*) from tblcustomers c
            inner join tblemphospitals eh on c.customerId = eh.hospitalId
            where empID = e.empid and isdisabled = 0 and SpecialtyId in (2)) as TotalIVFCount 
            from tblemployees e where 
            1 = 1
            and isdisabled = 0 
            AND empId IN (SELECT empId FROM #empHierarchy)  
        --  and e.EmpID = @empid or @empid is null
            and designationid in (3)
            ORDER BY e.FIRSTname  

            -- USP_VALIDATE_TEAM_PROGRESS_REPORT  61

            select eh.empID, c.customerId, c.CENTRENAME, c.DoctorName, 
                case 
                when hp.potentialenteredfor is null then 'NO'
                else 'YES' 
                end as PotentialedEntered
                from tblCustomers c 
            inner join tblEmpHospitals eh on eh.hospitalID = c.customerId 
            left  join TblHospitalsPotentials hp on hp.hospitalID = c.customerId and hp.potentialenteredfor = @addedFor
            where c.SpecialtyId in (2)
           --  and eh.EmpID = @empid or @empid is null
            AND eh.EmpID IN (SELECT empId FROM #empHierarchy) 
            order by customerId ASC


            select 
             eh.empID, c.customerId, c.CENTRENAME, c.DoctorName
                , case 
                when ha.actualEnteredFor is null then 'NO'
                else 'YES' 
                end as BusinessdEntered
                from tblCustomers c 
            inner join tblEmpHospitals eh on eh.hospitalID = c.customerId 
            left  join tblhospitalactuals ha on ha.hospitalID = c.customerId and ha.actualEnteredFor = @addedFor
            where c.SpecialtyId in (2)
            --  and eh.EmpID = @empid or @empid is null
            AND eh.EmpID IN (SELECT empId FROM #empHierarchy) 
            group by eh.empID, c.customerId, c.CENTRENAME, c.DoctorName, actualEnteredFor
            order by c.customerId ASC
            -- USP_VALIDATE_TEAM_PROGRESS_REPORT  811


            select 
             eh.empID, c.customerId, c.CENTRENAME, c.DoctorName
                , case 
                when ha.addedfor is null then 'NO'
                else 'YES' 
                end as MarketInsightdEntered
                from tblCustomers c 
            inner join tblEmpHospitals eh on eh.hospitalID = c.customerId 
            left  join tblMarketInsights ha on ha.centreId = c.customerId and ha.addedfor = @addedFor
            where c.SpecialtyId in (2)
            --  and eh.EmpID = @empid or @empid is null
            AND eh.EmpID IN (SELECT empId FROM #empHierarchy) 
            order by c.customerId ASC

        -- USP_VALIDATE_TEAM_PROGRESS_REPORT  811

            select 
             eh.empID, c.customerId, c.CENTRENAME, c.DoctorName
                , case 
                when ha.competitionAddedFor is null then 'NO'
                else 'YES' 
                end as CompEntered
                from tblCustomers c 
            inner join tblEmpHospitals eh on eh.hospitalID = c.customerId 
            left  join tblCompetitions ha on ha.centerId = c.customerId and ha.competitionAddedFor = @addedFor
            where c.SpecialtyId in (2)
            --  and eh.EmpID = @empid or @empid is null
            AND eh.EmpID IN (SELECT empId FROM #empHierarchy) 
            group by eh.empID, c.customerId, c.CENTRENAME, c.DoctorName, competitionAddedFor
            order by c.customerId ASC



        END
    --SET NOCOUNT OFF;  

 
GO
/****** Object:  StoredProcedure [BSV_IVF].[USP_VALIDATE_USER]    Script Date: 08-04-2023 13:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- USP_VALIDATE_USER 'khushbu.kumari@bsvl.com', 'BSV@112233'      
----------------------------------------------      
-- CREATED BY: GURU SINGH      
-- CREATD DATE: 9-SEP-2021      
----------------------------------------------      
CREATE procedure [BSV_IVF].[USP_VALIDATE_USER]
(          
    @email VARCHAR(150),          
    @password varchar(150)    
)      
as
set NOCOUNT on;
    declare @EmpID int;
        -- SELECT * FROM tblEmployees WHERE email = @email and password = @password and isDisabled = 0     
    IF EXISTS (SELECT 1 FROM tblEmployees WHERE email = @email and password = @password and isDisabled = 0)           
        BEGIN
            SELECT @EmpID = EmpID from tblEmployees
                WHERE email = @email and password = @password and isDisabled = 0
            -- select * from tblLastLoginDetails WHERE empID = @EmpID AND isLastLogin = 0
            if Exists(select 1 from tblLastLoginDetails WHERE empID = @EmpID AND isLastLogin = 0)              
                BEGIN
                    update tblLastLoginDetails set isLastLogin = 1 WHERE empID = @EmpID AND isLastLogin = 0
                        INSERT into tblLastLoginDetails (EmpID, isLastLogin)
                        VALUES (@EmpID, 0)
                END          
            else               
                BEGIN
                    INSERT into tblLastLoginDetails (EmpID, isLastLogin)
                    VALUES (@EmpID, 0)
                END
        END
    SELECT e.*, l.isLastLogin, l.lastLoginDate FROM tblEmployees E INNER JOIN tblLastLoginDetails L ON E.EmpID = L.EMPID    
    WHERE email = @email and password = @password and isDisabled = 0 AND L.isLastLogin = 0
set NOCOUNT off; 
GO
