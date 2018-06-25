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
         var result:Array = [];
         if(Annex1)
         {
            result.push(Annex1);
         }
         if(Annex2)
         {
            result.push(Annex2);
         }
         if(Annex3)
         {
            result.push(Annex3);
         }
         if(Annex4)
         {
            result.push(Annex4);
         }
         if(Annex5)
         {
            result.push(Annex5);
         }
         if(Gold != 0)
         {
            result.push("gold");
         }
         if(Money != 0)
         {
            result.push("money");
         }
         if(BindMoney != 0)
         {
            result.push("bindMoney");
         }
         if(Medal > 0)
         {
            result.push("medal");
         }
         return result;
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
                           addr26:
                           return true;
                        }
                        addr25:
                        §§goto(addr26);
                     }
                     addr24:
                     §§goto(addr25);
                  }
                  addr23:
                  §§goto(addr24);
               }
               addr22:
               §§goto(addr23);
            }
            addr21:
            §§goto(addr22);
         }
         §§goto(addr21);
      }
      
      public function getAnnexByIndex(index:int) : *
      {
         var result:* = undefined;
         var annexs:Array = getAnnexs();
         if(index > -1)
         {
            result = annexs[index];
         }
         return result;
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
