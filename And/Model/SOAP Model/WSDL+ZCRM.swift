import WSDL2Swift
import BrightFutures
import AEXML
import Fuzi
public struct ZCRM_MOBILE_FORM_WS: WSDLService {
    public let targetNamespace = "urn:sap-com:document:sap:soap:functions:mc-style"
    public var endpoint: String
    public let path = "sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws"
    public var interceptURLRequest: ((URLRequest) -> URLRequest)?
    public var interceptResponse: ((Data?, URLResponse?, Error?) -> (Data?, URLResponse?, Error?))?
    public init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    public func request(_ parameters: ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWs) -> Future<ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWsResponse, WSDLOperationError> {
        return requestGeneric(parameters)
    }
    public func request(_ parameters: ZCRM_MOBILE_FORM_WS_ZcrmCreateSurveyWs) -> Future<ZCRM_MOBILE_FORM_WS_ZcrmCreateSurveyWsResponse, WSDLOperationError> {
        return requestGeneric(parameters)
    }
    public func request(_ parameters: ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWs) -> Future<ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWsResponse, WSDLOperationError> {
        return requestGeneric(parameters)
    }
    public func request(_ parameters: ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWs) -> Future<ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWsResponse, WSDLOperationError> {
        return requestGeneric(parameters)
    }
    public func request(_ parameters: ZCRM_MOBILE_FORM_WS_ZcrmGetSurveyDataWs) -> Future<ZCRM_MOBILE_FORM_WS_ZcrmGetSurveyDataWsResponse, WSDLOperationError> {
        return requestGeneric(parameters)
    }
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs {
    public var NameFirst: String //char40
    public var NameLast: String //char40
    public var Birthdate: String //date10
    public var Sex: String //char1
    public var MaritalStat: String //char1
    public var MobileNo: String //char30
    public var Email: String //char241
    public var Job: String //char30
    public var Education: String //char30
    public var Company: String //char30
    public var Project: String //char20
    public var Approval: String //ZCRM_MOBILE_FORM_WS_char1
    public var Country: String //ZCRM_MOBILE_FORM_WS_char3
    public var Region: String //ZCRM_MOBILE_FORM_WS_char3
    public var City: String //ZCRM_MOBILE_FORM_WS_char40
    public var County: String //ZCRM_MOBILE_FORM_WS_char40
    public var Street: String //ZCRM_MOBILE_FORM_WS_char60
    public var HouseNo: String //ZCRM_MOBILE_FORM_WS_char10
    public var PostCode: String //ZCRM_MOBILE_FORM_WS_char10
    public var Township: String //ZCRM_MOBILE_FORM_WS_char40
    public var DaireTip1: String //ZCRM_MOBILE_FORM_WS_char1
    public var DaireTip2: String //ZCRM_MOBILE_FORM_WS_char1
    public var DaireTip3: String //ZCRM_MOBILE_FORM_WS_char1
    public var DaireTip4: String //ZCRM_MOBILE_FORM_WS_char1
    public var SatinAmac: String //ZCRM_MOBILE_FORM_WS_char2
    public var OdemeTercih: String //ZCRM_MOBILE_FORM_WS_char2
    public var HaberdarOlma: String //ZCRM_MOBILE_FORM_WS_char3
}

public struct ZCRM_MOBILE_FORM_WS_Bapiret2 {
    public var `Type`: String //char1
    public var Id: String //char20
    public var Number: Int32 //numeric3
    public var Message: String //char220
    public var LogNo: String //char20
    public var LogMsgNo: Int32 //numeric6
    public var MessageV1: String //char50
    public var MessageV2: String //char50
    public var MessageV3: String //char50
    public var MessageV4: String //char50
    public var Parameter: String //char32
    public var Row: Int32
    public var Field: String //char30
    public var System: String //char10
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmSSurveyCreateWs {
    public var ObjectId: String //ZCRM_MOBILE_FORM_WS_char10
    public var Questions: ZCRM_MOBILE_FORM_WS_ZcrmTtSurveyQuestWs
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmSSurveyQuestWs {
    public var QuestionId: String //ZCRM_MOBILE_FORM_WS_string
    public var AnswerId: String //ZCRM_MOBILE_FORM_WS_string
    public var QuestionText: String //ZCRM_MOBILE_FORM_WS_string
    public var `Type`: String //ZCRM_MOBILE_FORM_WS_string
    public var Answers: ZCRM_MOBILE_FORM_WS_ZcrmTtSurveyAnswWs
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmSSurveyAnswWs {
    public var Id: String //ZCRM_MOBILE_FORM_WS_string
    public var Text: String //ZCRM_MOBILE_FORM_WS_string
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmSJobSh {
    public var Value: String //char30
    public var ValueDescr: String //char90
}

public struct ZCRM_MOBILE_FORM_WS_BspWdDropdownLine {
    public var Key: String //ZCRM_MOBILE_FORM_WS_char40
    public var Value: String //ZCRM_MOBILE_FORM_WS_char80
}

public struct ZCRM_MOBILE_FORM_WS_Bapiret2T {
    public var item: [ZCRM_MOBILE_FORM_WS_Bapiret2]
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmTtSurveyQuestWs {
    public var item: [ZCRM_MOBILE_FORM_WS_ZcrmSSurveyQuestWs]
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmTtSurveyAnswWs {
    public var item: [ZCRM_MOBILE_FORM_WS_ZcrmSSurveyAnswWs]
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmTtJobSh {
    public var item: [ZCRM_MOBILE_FORM_WS_ZcrmSJobSh]
}

public struct ZCRM_MOBILE_FORM_WS_BspWdDropdownTable {
    public var item: [ZCRM_MOBILE_FORM_WS_BspWdDropdownLine]
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWs {
    public var IsData: ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs?
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWsResponse {
    public var EtReturn: ZCRM_MOBILE_FORM_WS_Bapiret2T
    public var EvObjectId: String //ZCRM_MOBILE_FORM_WS_char10
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmCreateSurveyWs {
    public var IsSurveyData: ZCRM_MOBILE_FORM_WS_ZcrmSSurveyCreateWs?
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmCreateSurveyWsResponse {
    public var EtReturn: ZCRM_MOBILE_FORM_WS_Bapiret2T
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWs {
    public var IvAttribute: String //char30?
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWsResponse {
    public var EtAttrList: ZCRM_MOBILE_FORM_WS_ZcrmTtJobSh
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWs {
    public var IvCountry: String //ZCRM_MOBILE_FORM_WS_char3?
    public var IvFieldname: String //ZCRM_MOBILE_FORM_WS_char50
    public var IvRegion: String //ZCRM_MOBILE_FORM_WS_char3?
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWsResponse {
    public var EtValues: ZCRM_MOBILE_FORM_WS_BspWdDropdownTable
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmGetSurveyDataWs {
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmGetSurveyDataWsResponse {
    public var EtSurveyData: ZCRM_MOBILE_FORM_WS_ZcrmTtSurveyQuestWs
}

extension ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.NameFirst = try parseXSDType(xml.children(staticTag: "NameFirst"))
            self.NameLast = try parseXSDType(xml.children(staticTag: "NameLast"))
            self.Birthdate = try parseXSDType(xml.children(staticTag: "Birthdate"))
            self.Sex = try parseXSDType(xml.children(staticTag: "Sex"))
            self.MaritalStat = try parseXSDType(xml.children(staticTag: "MaritalStat"))
            self.MobileNo = try parseXSDType(xml.children(staticTag: "MobileNo"))
            self.Email = try parseXSDType(xml.children(staticTag: "Email"))
            self.Job = try parseXSDType(xml.children(staticTag: "Job"))
            self.Education = try parseXSDType(xml.children(staticTag: "Education"))
            self.Company = try parseXSDType(xml.children(staticTag: "Company"))
            self.Project = try parseXSDType(xml.children(staticTag: "Project"))
            self.Approval = try parseXSDType(xml.children(staticTag: "Approval"))
            self.Country = try parseXSDType(xml.children(staticTag: "Country"))
            self.Region = try parseXSDType(xml.children(staticTag: "Region"))
            self.City = try parseXSDType(xml.children(staticTag: "City"))
            self.County = try parseXSDType(xml.children(staticTag: "County"))
            self.Street = try parseXSDType(xml.children(staticTag: "Street"))
            self.HouseNo = try parseXSDType(xml.children(staticTag: "HouseNo"))
            self.PostCode = try parseXSDType(xml.children(staticTag: "PostCode"))
            self.Township = try parseXSDType(xml.children(staticTag: "Township"))
            self.DaireTip1 = try parseXSDType(xml.children(staticTag: "DaireTip1"))
            self.DaireTip2 = try parseXSDType(xml.children(staticTag: "DaireTip2"))
            self.DaireTip3 = try parseXSDType(xml.children(staticTag: "DaireTip3"))
            self.DaireTip4 = try parseXSDType(xml.children(staticTag: "DaireTip4"))
            self.SatinAmac = try parseXSDType(xml.children(staticTag: "SatinAmac"))
            self.OdemeTercih = try parseXSDType(xml.children(staticTag: "OdemeTercih"))
            self.HaberdarOlma = try parseXSDType(xml.children(staticTag: "HaberdarOlma"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("NameFirst", NameFirst, ""),
        ("NameLast", NameLast, ""),
        ("Birthdate", Birthdate, ""),
        ("Sex", Sex, ""),
        ("MaritalStat", MaritalStat, ""),
        ("MobileNo", MobileNo, ""),
        ("Email", Email, ""),
        ("Job", Job, ""),
        ("Education", Education, ""),
        ("Company", Company, ""),
        ("Project", Project, ""),
        ("Approval", Approval, ""),
        ("Country", Country, ""),
        ("Region", Region, ""),
        ("City", City, ""),
        ("County", County, ""),
        ("Street", Street, ""),
        ("HouseNo", HouseNo, ""),
        ("PostCode", PostCode, ""),
        ("Township", Township, ""),
        ("DaireTip1", DaireTip1, ""),
        ("DaireTip2", DaireTip2, ""),
        ("DaireTip3", DaireTip3, ""),
        ("DaireTip4", DaireTip4, ""),
        ("SatinAmac", SatinAmac, ""),
        ("OdemeTercih", OdemeTercih, ""),
        ("HaberdarOlma", HaberdarOlma, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_Bapiret2: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.Type = try parseXSDType(xml.children(staticTag: "Type"))
            self.Id = try parseXSDType(xml.children(staticTag: "Id"))
            self.Number = try parseXSDType(xml.children(staticTag: "Number"))
            self.Message = try parseXSDType(xml.children(staticTag: "Message"))
            self.LogNo = try parseXSDType(xml.children(staticTag: "LogNo"))
            self.LogMsgNo = try parseXSDType(xml.children(staticTag: "LogMsgNo"))
            self.MessageV1 = try parseXSDType(xml.children(staticTag: "MessageV1"))
            self.MessageV2 = try parseXSDType(xml.children(staticTag: "MessageV2"))
            self.MessageV3 = try parseXSDType(xml.children(staticTag: "MessageV3"))
            self.MessageV4 = try parseXSDType(xml.children(staticTag: "MessageV4"))
            self.Parameter = try parseXSDType(xml.children(staticTag: "Parameter"))
            self.Row = try parseXSDType(xml.children(staticTag: "Row"))
            self.Field = try parseXSDType(xml.children(staticTag: "Field"))
            self.System = try parseXSDType(xml.children(staticTag: "System"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("Type", Type, ""),
        ("Id", Id, ""),
        ("Number", Number, ""),
        ("Message", Message, ""),
        ("LogNo", LogNo, ""),
        ("LogMsgNo", LogMsgNo, ""),
        ("MessageV1", MessageV1, ""),
        ("MessageV2", MessageV2, ""),
        ("MessageV3", MessageV3, ""),
        ("MessageV4", MessageV4, ""),
        ("Parameter", Parameter, ""),
        ("Row", Row, ""),
        ("Field", Field, ""),
        ("System", System, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmSSurveyCreateWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.ObjectId = try parseXSDType(xml.children(staticTag: "ObjectId"))
            self.Questions = try parseXSDType(xml.children(staticTag: "Questions"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("ObjectId", ObjectId, ""),
        ("Questions", Questions, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmSSurveyQuestWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.QuestionId = try parseXSDType(xml.children(staticTag: "QuestionId"))
            self.AnswerId = try parseXSDType(xml.children(staticTag: "AnswerId"))
            self.QuestionText = try parseXSDType(xml.children(staticTag: "QuestionText"))
            self.Type = try parseXSDType(xml.children(staticTag: "Type"))
            self.Answers = try parseXSDType(xml.children(staticTag: "Answers"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("QuestionId", QuestionId, ""),
        ("AnswerId", AnswerId, ""),
        ("QuestionText", QuestionText, ""),
        ("Type", Type, ""),
        ("Answers", Answers, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmSSurveyAnswWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.Id = try parseXSDType(xml.children(staticTag: "Id"))
            self.Text = try parseXSDType(xml.children(staticTag: "Text"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("Id", Id, ""),
        ("Text", Text, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmSJobSh: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.Value = try parseXSDType(xml.children(staticTag: "Value"))
            self.ValueDescr = try parseXSDType(xml.children(staticTag: "ValueDescr"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("Value", Value, ""),
        ("ValueDescr", ValueDescr, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_BspWdDropdownLine: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.Key = try parseXSDType(xml.children(staticTag: "Key"))
            self.Value = try parseXSDType(xml.children(staticTag: "Value"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("Key", Key, ""),
        ("Value", Value, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_Bapiret2T: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.item = try parseXSDType(xml.children(staticTag: "item"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("item", item, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmTtSurveyQuestWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.item = try parseXSDType(xml.children(staticTag: "item"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("item", item, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmTtSurveyAnswWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.item = try parseXSDType(xml.children(staticTag: "item"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("item", item, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmTtJobSh: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.item = try parseXSDType(xml.children(staticTag: "item"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("item", item, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_BspWdDropdownTable: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.item = try parseXSDType(xml.children(staticTag: "item"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("item", item, ""),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.IsData = try parseXSDType(xml.children(staticTag: "IsData"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("IsData", IsData, "tns"),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWsResponse: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.EtReturn = try parseXSDType(xml.children(staticTag: "EtReturn"))
            self.EvObjectId = try parseXSDType(xml.children(staticTag: "EvObjectId"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("EtReturn", EtReturn, "tns"),
        ("EvObjectId", EvObjectId, "tns"),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmCreateSurveyWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.IsSurveyData = try parseXSDType(xml.children(staticTag: "IsSurveyData"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("IsSurveyData", IsSurveyData, "tns"),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmCreateSurveyWsResponse: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.EtReturn = try parseXSDType(xml.children(staticTag: "EtReturn"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("EtReturn", EtReturn, "tns"),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.IvAttribute = try parseXSDType(xml.children(staticTag: "IvAttribute"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("IvAttribute", IvAttribute, "tns"),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWsResponse: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.EtAttrList = try parseXSDType(xml.children(staticTag: "EtAttrList"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("EtAttrList", EtAttrList, "tns"),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.IvCountry = try parseXSDType(xml.children(staticTag: "IvCountry"))
            self.IvFieldname = try parseXSDType(xml.children(staticTag: "IvFieldname"))
            self.IvRegion = try parseXSDType(xml.children(staticTag: "IvRegion"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("IvCountry", IvCountry, "tns"),
        ("IvFieldname", IvFieldname, "tns"),
        ("IvRegion", IvRegion, "tns"),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWsResponse: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.EtValues = try parseXSDType(xml.children(staticTag: "EtValues"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("EtValues", EtValues, "tns"),
        ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmGetSurveyDataWs: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [    ]}
}

extension ZCRM_MOBILE_FORM_WS_ZcrmGetSurveyDataWsResponse: ExpressibleByXML, XSDType {
    public init?(xml: Fuzi.XMLElement) {
        do {
            self.EtSurveyData = try parseXSDType(xml.children(staticTag: "EtSurveyData"))
        } catch _ {
            return nil
        }
    }
    public var xmlParams: [(String, SOAPParamConvertible?, String)] {return [
        ("EtSurveyData", EtSurveyData, "tns"),
        ]}
}
