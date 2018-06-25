package mx.core{   use namespace mx_internal;      public class RSLData   {            mx_internal static const VERSION:String = "4.6.0.23201";                   private var _applicationDomainTarget:String;            private var _digest:String;            private var _hashType:String;            private var _isSigned:Boolean;            private var _moduleFactory:IFlexModuleFactory;            private var _policyFileURL:String;            private var _rslURL:String;            private var _verifyDigest:Boolean;            public function RSLData(rslURL:String = null, policyFileURL:String = null, digest:String = null, hashType:String = null, isSigned:Boolean = false, verifyDigest:Boolean = false, applicationDomainTarget:String = "default") { super(); }
            public function get applicationDomainTarget() : String { return null; }
            public function get digest() : String { return null; }
            public function get hashType() : String { return null; }
            public function get isSigned() : Boolean { return false; }
            public function get moduleFactory() : IFlexModuleFactory { return null; }
            public function set moduleFactory(moduleFactory:IFlexModuleFactory) : void { }
            public function get policyFileURL() : String { return null; }
            public function get rslURL() : String { return null; }
            public function get verifyDigest() : Boolean { return false; }
   }}