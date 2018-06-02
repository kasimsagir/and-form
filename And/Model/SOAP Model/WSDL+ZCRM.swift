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
    public func request(_ parameters: ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWs) -> Future<ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWsResponse, WSDLOperationError> {
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

public struct ZCRM_MOBILE_FORM_WS_ZcrmSJobSh {
    public var Value: String //char30
    public var ValueDescr: String //char90
}

public struct ZCRM_MOBILE_FORM_WS_Bapiret2T {
    public var item: [ZCRM_MOBILE_FORM_WS_Bapiret2]
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmTtJobSh {
    public var item: [ZCRM_MOBILE_FORM_WS_ZcrmSJobSh]
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWs {
    public var IsData: ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs?
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWsResponse {
    public var EtReturn: ZCRM_MOBILE_FORM_WS_Bapiret2T
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWs {
    public var IvAttribute: String //char30?
}

public struct ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWsResponse {
    public var EtAttrList: ZCRM_MOBILE_FORM_WS_ZcrmTtJobSh
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

