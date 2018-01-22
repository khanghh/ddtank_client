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
      
      public function RedEnvelopeModel()
      {
         emptyList = [];
         _hasGotList = [];
         _canGetList = [];
         _currentRedList = [];
         _myRedEnvelopeList = [];
         _newRedEnvelope = new RedInfo();
         super();
      }
      
      public function get beginDateStr() : String
      {
         return _beginDateStr;
      }
      
      public function set beginDateStr(param1:String) : void
      {
         _beginDateStr = param1;
      }
      
      public function get endDateStr() : String
      {
         return _endDateStr;
      }
      
      public function set endDateStr(param1:String) : void
      {
         _endDateStr = param1;
      }
      
      public function get hasGotList() : Array
      {
         return _hasGotList;
      }
      
      public function set hasGotList(param1:Array) : void
      {
         _hasGotList = param1;
      }
      
      public function get canGetList() : Array
      {
         return _canGetList;
      }
      
      public function set canGetList(param1:Array) : void
      {
         _canGetList = param1;
      }
      
      public function get currentRedList() : Array
      {
         return _currentRedList;
      }
      
      public function set currentRedList(param1:Array) : void
      {
         _currentRedList = param1;
      }
      
      public function get myRedEnvelopeList() : Array
      {
         return _myRedEnvelopeList;
      }
      
      public function set myRedEnvelopeList(param1:Array) : void
      {
         _myRedEnvelopeList = param1;
      }
      
      public function get currentRedId() : int
      {
         return _currentRedId;
      }
      
      public function set currentRedId(param1:int) : void
      {
         _currentRedId = param1;
      }
      
      public function get newRedEnvelope() : RedInfo
      {
         return _newRedEnvelope;
      }
      
      public function set newRedEnvelope(param1:RedInfo) : void
      {
         _newRedEnvelope = param1;
      }
   }
}
