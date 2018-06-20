//
//  UserUtils.swift
//  And
//
//  Created by kasım on 8.06.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation

class UserUtils {
    
    static func getNameFirst()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "NameFirst") ?? ""
    }
    static func setNameFirst(NameFirst:String){
        let defaults = UserDefaults.standard
        defaults.set(NameFirst, forKey: "NameFirst")
        defaults.synchronize()
    }
    
    static func getNameLast()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "NameLast") ?? ""
    }
    static func setNameLast(NameLast:String){
        let defaults = UserDefaults.standard
        defaults.set(NameLast, forKey: "NameLast")
        defaults.synchronize()
    }
    
    static func getBirthdate()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Birthdate") ?? ""
    }
    static func setBirthdate(Birthdate:String){
        let defaults = UserDefaults.standard
        defaults.set(Birthdate, forKey: "Birthdate")
        defaults.synchronize()
    }
    
    static func getFormatBirthdate()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "FormatBirthdate") ?? ""
    }
    static func setFormatBirthdate(FormatBirthdate:String){
        let defaults = UserDefaults.standard
        defaults.set(FormatBirthdate, forKey: "FormatBirthdate")
        defaults.synchronize()
    }
    
    static func getSex()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Sex") ?? ""
    }
    static func setSex(Sex:String){
        let defaults = UserDefaults.standard
        defaults.set(Sex, forKey: "Sex")
        defaults.synchronize()
    }
    
    static func getMaritalStat()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "MaritalStat") ?? ""
    }
    static func setMaritalStat(MaritalStat:String){
        let defaults = UserDefaults.standard
        defaults.set(MaritalStat, forKey: "MaritalStat")
        defaults.synchronize()
    }
    
    static func getMobileNo()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "MobileNo") ?? ""
    }
    static func setMobileNo(MobileNo:String){
        let defaults = UserDefaults.standard
        defaults.set(MobileNo, forKey: "MobileNo")
        defaults.synchronize()
    }
    
    static func getEmail()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Email") ?? ""
    }
    static func setEmail(Email:String){
        let defaults = UserDefaults.standard
        defaults.set(Email, forKey: "Email")
        defaults.synchronize()
    }
    
    static func getJob()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Job") ?? ""
    }
    static func setJob(Job:String){
        let defaults = UserDefaults.standard
        defaults.set(Job, forKey: "Job")
        defaults.synchronize()
    }
    
    static func getJobDescription()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "JobDescription") ?? ""
    }
    static func setJobDescription(JobDescription:String){
        let defaults = UserDefaults.standard
        defaults.set(JobDescription, forKey: "JobDescription")
        defaults.synchronize()
    }
    
    static func getEducation()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Education") ?? ""
    }
    static func setEducation(Education:String){
        let defaults = UserDefaults.standard
        defaults.set(Education, forKey: "Education")
        defaults.synchronize()
    }
    
    static func getCompany()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Company") ?? ""
    }
    static func setCompany(Company:String){
        let defaults = UserDefaults.standard
        defaults.set(Company, forKey: "Company")
        defaults.synchronize()
    }
    
    static func getProject()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Project") ?? ""
    }
    static func setProject(Project:String){
        let defaults = UserDefaults.standard
        defaults.set(Project, forKey: "Project")
        defaults.synchronize()
    }
    
    static func getApproval()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Approval") ?? ""
    }
    static func setApproval(Approval:String){
        let defaults = UserDefaults.standard
        defaults.set(Approval, forKey: "Approval")
        defaults.synchronize()
    }
    
    static func getCountry()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Country") ?? ""
    }
    static func setCountry(Country:String){
        let defaults = UserDefaults.standard
        defaults.set(Country, forKey: "Country")
        defaults.synchronize()
    }
    
    static func getCountryName()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "CountryName") ?? ""
    }
    static func setCountryName(CountryName:String){
        let defaults = UserDefaults.standard
        defaults.set(CountryName, forKey: "CountryName")
        defaults.synchronize()
    }
    
    static func getRegion()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Region") ?? ""
    }
    static func setRegion(Region:String){
        let defaults = UserDefaults.standard
        defaults.set(Region, forKey: "Region")
        defaults.synchronize()
    }
    
    static func getRegionName()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "RegionName") ?? ""
    }
    static func setRegionName(RegionName:String){
        let defaults = UserDefaults.standard
        defaults.set(RegionName, forKey: "RegionName")
        defaults.synchronize()
    }
    
    static func getCity()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "City") ?? ""
    }
    static func setCity(City:String){
        let defaults = UserDefaults.standard
        defaults.set(City, forKey: "City")
        defaults.synchronize()
    }
    
    static func getCityDetail()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "CityDetail") ?? ""
    }
    static func setCityDetail(CityDetail:String){
        let defaults = UserDefaults.standard
        defaults.set(CityDetail, forKey: "CityDetail")
        defaults.synchronize()
    }
    
    static func getTown()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Town") ?? ""
    }
    static func setTown(Town:String){
        let defaults = UserDefaults.standard
        defaults.set(Town, forKey: "Town")
        defaults.synchronize()
    }
    
    static func getPostCode()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "PostCode") ?? ""
    }
    static func setPostCode(PostCode:String){
        let defaults = UserDefaults.standard
        defaults.set(PostCode, forKey: "PostCode")
        defaults.synchronize()
    }
    
    static func getStreet()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "Street") ?? ""
    }
    static func setStreet(Street:String){
        let defaults = UserDefaults.standard
        defaults.set(Street, forKey: "Street")
        defaults.synchronize()
    }
    
    static func getHouseNo()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "HouseNo") ?? ""
    }
    static func setHouseNo(HouseNo:String){
        let defaults = UserDefaults.standard
        defaults.set(HouseNo, forKey: "HouseNo")
        defaults.synchronize()
    }
    
    static func getPayType()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "PayType") ?? ""
    }
    static func setPayType(PayType:String){
        let defaults = UserDefaults.standard
        defaults.set(PayType, forKey: "PayType")
        defaults.synchronize()
    }
    
    static func getApartmentType1()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "ApartmentType1") ?? ""
    }
    static func setApartmentType1(ApartmentType1:String){
        let defaults = UserDefaults.standard
        defaults.set(ApartmentType1, forKey: "ApartmentType1")
        defaults.synchronize()
    }
    
    static func getApartmentType2()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "ApartmentType2") ?? ""
    }
    static func setApartmentType2(ApartmentType2:String){
        let defaults = UserDefaults.standard
        defaults.set(ApartmentType2, forKey: "ApartmentType2")
        defaults.synchronize()
    }
    
    static func getApartmentType3()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "ApartmentType3") ?? ""
    }
    static func setApartmentType3(ApartmentType3:String){
        let defaults = UserDefaults.standard
        defaults.set(ApartmentType3, forKey: "ApartmentType3")
        defaults.synchronize()
    }
    
    static func getApartmentType4()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "ApartmentType4") ?? ""
    }
    static func setApartmentType4(ApartmentType4:String){
        let defaults = UserDefaults.standard
        defaults.set(ApartmentType4, forKey: "ApartmentType4")
        defaults.synchronize()
    }
    
    static func getPurposeType()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "PurposeType") ?? ""
    }
    static func setPurposeType(PurposeType:String){
        let defaults = UserDefaults.standard
        defaults.set(PurposeType, forKey: "PurposeType")
        defaults.synchronize()
    }
    
    static func getInformedType()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "InformedType") ?? ""
    }
    static func setInformedType(InformedType:String){
        let defaults = UserDefaults.standard
        defaults.set(InformedType, forKey: "InformedType")
        defaults.synchronize()
    }
    
    static func getObjectId()->String{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "ObjectId") ?? ""
    }
    static func setObjectId(ObjectId:String){
        let defaults = UserDefaults.standard
        defaults.set(ObjectId, forKey: "ObjectId")
        defaults.synchronize()
    }
    
    static func resetUser(){
        SurveyTableViewController.selectedChoices = []
        
        UserUtils.setNameFirst(NameFirst: "")
        UserUtils.setNameLast(NameLast: "")
        UserUtils.setBirthdate(Birthdate: "")
        UserUtils.setSex(Sex: "")
        UserUtils.setMaritalStat(MaritalStat: "")
        UserUtils.setMobileNo(MobileNo: "")
        UserUtils.setEmail(Email: "")
        UserUtils.setJob(Job: "")
        UserUtils.setJobDescription(JobDescription: "")
        UserUtils.setEducation(Education: "")
        UserUtils.setCompany(Company: "")
        UserUtils.setProject(Project: "")
        UserUtils.setApproval(Approval: "")
        UserUtils.setCountry(Country: "")
        UserUtils.setCountryName(CountryName: "")
        UserUtils.setRegion(Region: "")
        UserUtils.setRegionName(RegionName: "")
        UserUtils.setCity(City: "")
        UserUtils.setCityDetail(CityDetail: "")
        UserUtils.setTown(Town: "")
        UserUtils.setPostCode(PostCode: "")
        UserUtils.setStreet(Street: "")
        UserUtils.setHouseNo(HouseNo: "")
        UserUtils.setPayType(PayType: "")
        UserUtils.setApartmentType1(ApartmentType1: "")
        UserUtils.setApartmentType2(ApartmentType2: "")
        UserUtils.setApartmentType3(ApartmentType3: "")
        UserUtils.setApartmentType4(ApartmentType4: "")
        UserUtils.setPurposeType(PurposeType: "")
        UserUtils.setInformedType(InformedType: "")
    }
}










