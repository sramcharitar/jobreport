package jobreport

class DBLoader {
    def loadAll() {
        loadGeneral()
        loadUserRoles()
        loadUserState()
        loadChbUser()
        loadJobProgressStatus()
        loadWorkTypes()
        loadProductDeliveryMethod()
        //loadWageTypes()
        //loadRateTypes()
        loadInventoryStatus()
        loadSiteReportStatus()
        loadExpenseItems()
        loadPaymentMethod()

    }

    def addObject = { newObject ->
        newObject.save()
        if (newObject.hasErrors())
            println newObject.errors
        return newObject
    }

    def loadGeneral(){
        General.findOrSaveByNameEnumAndMessageCodeAndValueAndActive(GeneralEnum.TEAM_LEADER_PAY, "general.teamLeaderPay.label", "75.00", true)
        General.findOrSaveByNameEnumAndMessageCodeAndValueAndActive(GeneralEnum.OVER_TIME_THRESHOLD, "general.overtimeThreshold.label", "40", true)
        General.findOrSaveByNameEnumAndMessageCodeAndValueAndActive(GeneralEnum.LUNCH_PERIOD, "general.lunchPeriod.label", "0.5", true)
    }

    def loadUserState(){
        UserState.findOrSaveByState("Active")
        UserState.findOrSaveByState("Inactive")
    }

    def loadUserRoles(){
        Role.findOrSaveByAuthority("ROLE_ADMIN")
        Role.findOrSaveByAuthority("ROLE_PRINCIPAL")
        Role.findOrSaveByAuthority("ROLE_ACCOUNTING")
        Role.findOrSaveByAuthority("ROLE_ACCOUNT_MANAGER")
        Role.findOrSaveByAuthority("ROLE_PROJECT_MANAGER")
        Role.findOrSaveByAuthority("ROLE_FIELD_AGENT")
        Role.findOrSaveByAuthority("ROLE_SALES")
    }

    def createChbUser(List employeeList){
        def defaultPassword = "test123"
        employeeList.each{ employee ->
            ChbUsers user = ChbUsers.findByEmailAddress(employee.emailAddress)
            if (!user) {
                println "Adding user ${employee.firstName} ${employee.lastName}"
                user = addObject(new ChbUsers(
                        firstName:employee.firstName,
                        lastName:employee.lastName,
                        emailAddress:employee.emailAddress,
                        username:employee.username,
                        password:defaultPassword,
                        enabled:true,
                        calendar: false,
                        color: employee.color)
                )
                employee.authority.each{ role ->
                    ChbUsersRole.create(user, Role.findByAuthority(role))
                }
            }
        }
    }

    def loadChbUser() {
        List chbOfficeAdmins = [[firstName: "Shyam", lastName: "Ramcharitar", emailAddress: "sramcharitar@gmail.com", username: "sramcharitar", authority: ['ROLE_ADMIN'], color:  ""],
                                [firstName: "Carol", lastName: "Borow", emailAddress: "cborow@chbwindowfilm.com", username: "cborow", authority: ['ROLE_PRINCIPAL','ROLE_SALES'], color: "lightseagreen"],
                                [firstName: "Dan", lastName: "Venet", emailAddress: "dvenet@chbwindowfilm.com", username: "dvenet", authority: ['ROLE_PRINCIPAL', 'ROLE_SALES'], color: "lightcoral"],
                                [firstName: "Deborah", lastName: "Schulbaum", emailAddress: "dschulbaum@chbwindowfilm.com", username: "dschulbaum", authority: ['ROLE_ACCOUNTING'], color: ""],
                                [firstName: "David", lastName: "Farrugia", emailAddress: "dfarrugia@chbwindowfilm.com", username: "dfarrugia", authority: ['ROLE_PROJECT_MANAGER'], color: ""],
                                [firstName: "Shivana", lastName: "Singh", emailAddress: "ssingh@chbwindowfilm.com", username: "ssingh", authority: ['ROLE_ACCOUNT_MANAGER'], color: ""],
                                [firstName: "Amrita", lastName: "Singh", emailAddress: "asingh@chbwindowfilm.com", username: "asingh", authority: ['ROLE_ACCOUNT_MANAGER'], color: ""],
                                [firstName: "Marisa", lastName: "Ferrizz", emailAddress: "mferrizz@chbwindowfilm.com", username: "mferrizz", authority: ['ROLE_ACCOUNT_MANAGER'], color: ""]
        ]
        List fieldAgentList = [[firstName:"Marcelo", lastName:"Guaman", emailAddress:"guaman81@gmail.com", username:"mguaman", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Fernando", lastName:"Henriquez", emailAddress:"fernandoh1208@gmail.com", username:"fhenriquez", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Joffre", lastName:"Guaman", emailAddress:"jguaman83@hotmail.com", username:"jguaman", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Wellvin", lastName:"Ventura", emailAddress:"wellvin87@hotmail.com", username:"wventura", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Eduardo", lastName:"Andrade", emailAddress:"edu7gan@gmail.com", username:"eandrade", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Milton", lastName:"Ortiz", emailAddress:"tonmil076@hotmail.com", username:"mortiz", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Jorge", lastName:"Henriquez", emailAddress:"jorge052065@gmail.com", username:"jhenriquez", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Christian", lastName:"Henriquez", emailAddress:"christ92jhv@hotmail.com", username:"chenriquez", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Whendy", lastName:"Noblecita", emailAddress:"gwendolynnv80@gmail.com", username:"wnoblecita", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Jose Manny", lastName:"Almonte", emailAddress:"mendezalmonte17@gmail.com", username:"jmalmonte", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Edwin", lastName:"Espinal", emailAddress:"edwin-00@live.com", username:"eespinal", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Ken", lastName:"Golyzniak", emailAddress:"kgolyzniak@chbwindowfilm.com", username:"kgolyzniak", authority: ['ROLE_FIELD_AGENT'], color: ""],
                               [firstName:"Mark", lastName:"Borow", emailAddress:"mborow@chbwindowfilm.com", username:"mborow", authority: ['ROLE_FIELD_AGENT'], color: ""]]
        createChbUser(chbOfficeAdmins + fieldAgentList)
    }

    def loadJobProgressStatus(){
        JobProgressStatus.findOrSaveByState("Initial")
        JobProgressStatus.findOrSaveByState("Pending Review")
        JobProgressStatus.findOrSaveByState("Final")
    }

    def loadWorkTypes(){
        WorkTypes.findOrSaveByTypeAndMessageCode("Film Installation", "workTypes.install.label")
        WorkTypes.findOrSaveByTypeAndMessageCode("Film Removal", "workTypes.removal.label")
        WorkTypes.findOrSaveByTypeAndMessageCode("Both", "workTypes.both.label")
    }

    def loadProductDeliveryMethod(){
        ProductDeliveryMethod.findOrSaveByMethodAndMessageCode("Shipped from Warehouse","productDeliveryMethod.shipFromWarehouse.label")
        ProductDeliveryMethod.findOrSaveByMethodAndMessageCode("Shipped from Office","productDeliveryMethod.shipFromOffice.label")
        ProductDeliveryMethod.findOrSaveByMethodAndMessageCode("Shipped from Manufacturer","productDeliveryMethod.shipFromManufacturer.label")
        ProductDeliveryMethod.findOrSaveByMethodAndMessageCode("Provided by Client","productDeliveryMethod.providedByClient.label")
        ProductDeliveryMethod.findOrSaveByMethodAndMessageCode("Field Team Provided","productDeliveryMethod.fieldTeamProvided.label")
    }

    def loadWageTypes(){
        WageType.findOrSaveByTypeAndTypeEnumAndMessageCode("Standard Rate", WageTypeEnum.STANDARD_RATE, "rateCategoryEnum.STANDARD_RATE")
        WageType.findOrSaveByTypeAndTypeEnumAndMessageCode("Regional / Agency Rate", WageTypeEnum.REGIONAL_AGENCY_RATE, "rateCategoryEnum.REGIONAL_AGENCY_RATE")
        //WageType.findOrSaveByTypeAndTypeEnumAndMessageCode("Standard Wage", WageTypeEnum.STANDARD_WAGE, "wageType.standard.text")
        //WageType.findOrSaveByTypeAndTypeEnumAndMessageCode("Prevailing Wage", WageTypeEnum.PREVAILING_WAGE, "wageType.prevailing.text")
        //WageType.findOrSaveByTypeAndTypeEnumAndMessageCode("Union Wage", WageTypeEnum.UNION_WAGE,"wageType.union.text")
        //WageType.findOrSaveByTypeAndMessageCode("Special Rate", "wageType.specialRate.text")
        //WageType.findOrSaveByTypeAndMessageCode("Premium Rate", "wageType.premiumRate.text")
        //WageType.findOrSaveByTypeAndMessageCode("Double Rate", "wageType.doubleRate.text")
        //WageType.findOrSaveByTypeAndMessageCode("Other", "wageType.other.text")
    }

    def loadRateTypes(){
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("Hourly", WageTypeEnum.STANDARD_WAGE, RateTypeEnum.HOURLY, "rateType.hourly.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("Premium", WageTypeEnum.STANDARD_WAGE, RateTypeEnum.PREMIUM, "rateType.premium.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("PSF", WageTypeEnum.STANDARD_WAGE, RateTypeEnum.PSF, "rateType.psf.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("PLF", WageTypeEnum.STANDARD_WAGE, RateTypeEnum.PLF, "rateType.plf.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("Daily Minimum", WageTypeEnum.STANDARD_WAGE, RateTypeEnum.DAILY_MINIMUM, "rateType.dailyMinimum.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("New York", WageTypeEnum.PREVAILING_WAGE, RateTypeEnum.NEW_YORK, "rateType.newYork.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("New York R&M", WageTypeEnum.PREVAILING_WAGE, RateTypeEnum.NEW_YORK_R_AND_M, "rateType.newYorkRM.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("Illinois", WageTypeEnum.PREVAILING_WAGE, RateTypeEnum.ILLINOIS, "rateType.illinois.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("New Jersey", WageTypeEnum.PREVAILING_WAGE, RateTypeEnum.NEW_JERSEY, "rateType.newJersey.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("Connecticut", WageTypeEnum.PREVAILING_WAGE, RateTypeEnum.CONNECTICUT, "rateType.connecticut.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("NY DC9 A Rate (PLA)", WageTypeEnum.UNION_WAGE, RateTypeEnum.NY_DC9_A_RATE_PLA, "rateType.nyDc9ARatePla.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("NY DC9 B Rate (Full Rate)", WageTypeEnum.UNION_WAGE, RateTypeEnum.NY_DC9_B_RATE_FULL_RATE, "rateType.nyDc9BRateFullRate.text")
        RateType.findOrSaveByTypeAndWageTypeEnumAndRateTypeEnumAndMessageCode("IL Local 27", WageTypeEnum.UNION_WAGE, RateTypeEnum.IL_LOCAL_27, "rateType.ilLocalTwoSeven.text")
    }

    def loadInventoryStatus(){
        InventoryStatus.findOrSaveByStatusAndMessageCodeAndStatusEnum("Empty", "inventoryStatus.empty.label", InventoryStatusEnum.EMPTY)
        InventoryStatus.findOrSaveByStatusAndMessageCodeAndStatusEnum("Retuning to Warehouse", "inventoryStatus.returningToWarehouse.label", InventoryStatusEnum.RETURNING_TO_WAREHOUSE)
        InventoryStatus.findOrSaveByStatusAndMessageCodeAndStatusEnum("Returned to Warehouse", "inventoryStatus.returnedToWarehouse.label", InventoryStatusEnum.RETURNED_TO_WAREHOUSE)
        InventoryStatus.findOrSaveByStatusAndMessageCodeAndStatusEnum("Left with Client", "inventoryStatus.leftWithClient.label", InventoryStatusEnum.LEFT_WITH_CLIENT)
        InventoryStatus.findOrSaveByStatusAndMessageCodeAndStatusEnum("Other", "inventoryStatus.other.label", InventoryStatusEnum.OTHER)
    }

    def loadSiteReportStatus(){
        SiteReportStatus.findOrSaveByStatusAndMessageCodeAndStatusEnum("Work in Progress", "siteReport.inProgress.label", SiteReportStatusEnum.WORK_IN_PROGRESS)
        SiteReportStatus.findOrSaveByStatusAndMessageCodeAndStatusEnum("Job Completed", "siteReport.completed.label", SiteReportStatusEnum.JOB_COMPLETED)
    }

    def loadExpenseItems(){
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Gas", "expenseItems.gas.label", ExpenseItemsEnum.GAS)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Materials", "expenseItems.materials.label", ExpenseItemsEnum.MATERIALS)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Tools", "expenseItems.tools.label", ExpenseItemsEnum.TOOLS)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Parking", "expenseItems.parking.label", ExpenseItemsEnum.PARKING)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Toll", "expenseItems.toll.label", ExpenseItemsEnum.TOLL)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Train", "expenseItems.train.label", ExpenseItemsEnum.TRAIN)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Taxi", "expenseItems.taxi.label", ExpenseItemsEnum.TAXI)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Vehicle Rental", "expenseItems.vehicleRental.label", ExpenseItemsEnum.VEHICLE_RENTAL)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Office", "expenseItems.office.label", ExpenseItemsEnum.OFFICE)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Lodging", "expenseItems.lodging.label", ExpenseItemsEnum.LODGING)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Airfare", "expenseItems.airfare.label", ExpenseItemsEnum.AIRFARE)
        ExpenseItems.findOrSaveByItemAndMessageCodeAndItemEnum("Misc.", "expenseItems.misc.label", ExpenseItemsEnum.MISC)
    }

    def loadPaymentMethod(){
        PaymentMethod.findOrSaveByPaymentTypeAndMessageCodeAndPaymentMethodEnum("Vendor Account", "paymentMethod.vendor.label", PaymentMethodEnum.VENDOR_ACCOUNT)
        PaymentMethod.findOrSaveByPaymentTypeAndMessageCodeAndPaymentMethodEnum("Credit Card", "paymentMethod.creditcard.label", PaymentMethodEnum.CREDIT_CARD)
        PaymentMethod.findOrSaveByPaymentTypeAndMessageCodeAndPaymentMethodEnum("Other", "paymentMethod.cash.label", PaymentMethodEnum.OTHER)
    }

}