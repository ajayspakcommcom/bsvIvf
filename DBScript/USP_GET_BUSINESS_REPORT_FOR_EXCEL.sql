drop procedure [BSV_IVF].[USP_GET_BUSINESS_REPORT_FOR_EXCEL]   
go
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