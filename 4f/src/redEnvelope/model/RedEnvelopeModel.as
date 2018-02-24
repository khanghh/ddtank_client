package redEnvelope.model
{
   import flash.events.EventDispatcher;
   import redEnvelope.data.RedInfo;
   
   public class RedEnvelopeModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      public var emptyList:Array;
      
      private var _beginDateStr:String;
      
      private var _endDateStr:String;
      
      private var _hasGotList:Array;
      
      private var _canGetList:Array;
      
      private var _currentRedList:Array;
      
      private var _myRedEnvelopeList:Array;
      
      private var _currentRedId:int;
      
      private var _newRedEnvelope:RedInfo;
      
      public function RedEnvelopeModel(){super();}
      
      public function get beginDateStr() : String{return null;}
      
      public function set beginDateStr(param1:String) : void{}
      
      public function get endDateStr() : String{return null;}
      
      public function set endDateStr(param1:String) : void{}
      
      public function get hasGotList() : Array{return null;}
      
      public function set hasGotList(param1:Array) : void{}
      
      public function get canGetList() : Array{return null;}
      
      public function set canGetList(param1:Array) : void{}
      
      public function get currentRedList() : Array{return null;}
      
      public function set currentRedList(param1:Array) : void{}
      
      public function get myRedEnvelopeList() : Array{return null;}
      
      public function set myRedEnvelopeList(param1:Array) : void{}
      
      public function get currentRedId() : int{return 0;}
      
      public function set currentRedId(param1:int) : void{}
      
      public function get newRedEnvelope() : RedInfo{return null;}
      
      public function set newRedEnvelope(param1:RedInfo) : void{}
   }
}
