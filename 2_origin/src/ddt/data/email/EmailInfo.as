package ddt.data.email
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.utils.Dictionary;
   
   public class EmailInfo
   {
       
      
      public var ID:int;
      
      public var UserID:int;
      
      public var MailType:int;
      
      public var sendDate:Number;
      
      public var Content:String;
      
      public var Title:String;
      
      public var Sender:String;
      
      public var SenderID:int;
      
      public var ReceiverID:int;
      
      public var SendTime:String;
      
      public var Annexs:Dictionary;
      
      public var Annex1:InventoryItemInfo;
      
      public var Annex2:InventoryItemInfo;
      
      public var Annex3:InventoryItemInfo;
      
      public var Annex4:InventoryItemInfo;
      
      public var Annex5:InventoryItemInfo;
      
      public var Annex1ID:int;
      
      public var Annex2ID:int;
      
      public var Annex3ID:int;
      
      public var Annex4ID:int;
      
      public var Annex5ID:int;
      
      public var Gold:Number = 500;
      
      public var Money:Number = 600;
      
      public var BindMoney:Number = 0;
      
      public var Medal:int;
      
      public var ValidDate:int = 30;
      
      public var Type:int = 0;
      
      public var IsRead:Boolean = false;
      
      public function EmailInfo()
      {
         Content = LanguageMgr.GetTranslation("tank.data.EmailInfo.test");
         Title = LanguageMgr.GetTranslation("tank.data.EmailInfo.email");
         Sender = LanguageMgr.GetTranslation("tank.data.EmailInfo.random");
         super();
      }
      
      public function getAnnexs() : Array
      {
         var _loc1_:Array = [];
         if(Annex1)
         {
            _loc1_.push(Annex1);
         }
         if(Annex2)
         {
            _loc1_.push(Annex2);
         }
         if(Annex3)
         {
            _loc1_.push(Annex3);
         }
         if(Annex4)
         {
            _loc1_.push(Annex4);
         }
         if(Annex5)
         {
            _loc1_.push(Annex5);
         }
         if(Gold != 0)
         {
            _loc1_.push("gold");
         }
         if(Money != 0)
         {
            _loc1_.push("money");
         }
         if(BindMoney != 0)
         {
            _loc1_.push("bindMoney");
         }
         if(Medal > 0)
         {
            _loc1_.push("medal");
         }
         return _loc1_;
      }
      
      public function get canReply() : Boolean
      {
         if(PlayerManager.Instance.Self.ID == SenderID)
         {
            return false;
         }
         var _loc1_:* = Type;
         if(0 !== _loc1_)
         {
            if(1 !== _loc1_)
            {
               if(6 !== _loc1_)
               {
                  if(7 !== _loc1_)
                  {
                     if(10 !== _loc1_)
                     {
                        if(67 !== _loc1_)
                        {
                           if(101 !== _loc1_)
                           {
                              if(59 !== _loc1_)
                              {
                                 return false;
                              }
                           }
                           addr20:
                           return true;
                        }
                        addr19:
                        §§goto(addr20);
                     }
                     addr18:
                     §§goto(addr19);
                  }
                  addr17:
                  §§goto(addr18);
               }
               addr16:
               §§goto(addr17);
            }
            addr15:
            §§goto(addr16);
         }
         §§goto(addr15);
      }
      
      public function getAnnexByIndex(param1:int) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = getAnnexs();
         if(param1 > -1)
         {
            _loc3_ = _loc2_[param1];
         }
         return _loc3_;
      }
      
      public function hasAnnexs() : Boolean
      {
         if(Annex1 || Annex2 || Annex3 || Annex4 || Annex5)
         {
            return true;
         }
         return false;
      }
   }
}
