package ddt.manager{   import com.pickgliss.utils.StringUtils;   import flash.utils.Dictionary;      public class LanguageMgr   {            private static var _dic:Dictionary;            private static var _reg:RegExp = /\{(\d+)\}/;                   public function LanguageMgr() { super(); }
            public static function setup(content:String) : void { }
            private static function analyze(data:String) : void { }
            public static function GetTranslation(translationId:String, ... args) : String { return null; }
   }}