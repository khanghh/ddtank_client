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
      
      public function set beginDateStr(value:String) : void
      {
         _beginDateStr = value;
      }
      
      public function get endDateStr() : String
      {
         return _endDateStr;
      }
      
      public function set endDateStr(value:String) : void
      {
         _endDateStr = value;
      }
      
      public function get hasGotList() : Array
      {
         return _hasGotList;
      }
      
      public function set hasGotList(value:Array) : void
      {
         _hasGotList = value;
      }
      
      public function get canGetList() : Array
      {
         return _canGetList;
      }
      
      public function set canGetList(value:Array) : void
      {
         _canGetList = value;
      }
      
      public function get currentRedList() : Array
      {
         return _currentRedList;
      }
      
      public function set currentRedList(value:Array) : void
      {
         _currentRedList = value;
      }
      
      public function get myRedEnvelopeList() : Array
      {
         return _myRedEnvelopeList;
      }
      
      public function set myRedEnvelopeList(value:Array) : void
      {
         _myRedEnvelopeList = value;
      }
      
      public function get currentRedId() : int
      {
         return _currentRedId;
      }
      
      public function set currentRedId(value:int) : void
      {
         _currentRedId = value;
      }
      
      public function get newRedEnvelope() : RedInfo
      {
         return _newRedEnvelope;
      }
      
      public function set newRedEnvelope(value:RedInfo) : void
      {
         _newRedEnvelope = value;
      }
   }
}
