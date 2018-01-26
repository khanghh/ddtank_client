package ddt.data.email
{
   import ddt.events.EmailEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.TimeManager;
   import email.MailManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.utils.DateUtils;
   
   public class EmailModel extends EventDispatcher
   {
       
      
      public var isLoaded:Boolean = false;
      
      private var _sendedMails:Array;
      
      private var _noReadMails:Array;
      
      private var _emails:Array;
      
      private var _mailType:String = "all mails";
      
      private var _currentDate:Array;
      
      private var _state:String = "read";
      
      private var _currentPage:int = 1;
      
      private var _selectEmail:EmailInfo;
      
      public var lastTime:String;
      
      public function EmailModel(param1:IEventDispatcher = null){super(null);}
      
      public function set sendedMails(param1:Array) : void{}
      
      public function get sendedMails() : Array{return null;}
      
      public function get noReadMails() : Array{return null;}
      
      public function get emails() : Array{return null;}
      
      public function set emails(param1:Array) : void{}
      
      public function getValidateMails(param1:Array) : Array{return null;}
      
      public function set mailType(param1:String) : void{}
      
      public function get mailType() : String{return null;}
      
      public function get currentDate() : Array{return null;}
      
      public function set state(param1:String) : void{}
      
      public function get state() : String{return null;}
      
      private function resetModel() : void{}
      
      public function get totalPage() : int{return 0;}
      
      public function get currentPage() : int{return 0;}
      
      public function set currentPage(param1:int) : void{}
      
      public function getNoReadMails() : void{}
      
      public function getMailByID(param1:int) : EmailInfo{return null;}
      
      public function getViewData() : Array{return null;}
      
      private function calculateRemainTime(param1:String, param2:Number) : Number{return 0;}
      
      public function get selectEmail() : EmailInfo{return null;}
      
      public function set selectEmail(param1:EmailInfo) : void{}
      
      public function addEmail(param1:EmailInfo) : void{}
      
      public function addEmailToSended(param1:EmailInfoOfSended) : void{}
      
      public function removeFromNoRead(param1:EmailInfo) : void{}
      
      public function removeEmail(param1:EmailInfo) : void{}
      
      public function changeEmail(param1:EmailInfo) : void{}
      
      public function clearEmail() : void{}
      
      public function dispose() : void{}
      
      public function hasUnReadEmail() : Boolean{return false;}
      
      public function hasUnReadGiftEmail() : Boolean{return false;}
   }
}
