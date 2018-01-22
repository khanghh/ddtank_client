package ddt.dailyRecord
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.PkgEvent;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DailyRecordControl extends EventDispatcher
   {
      
      public static const RECORDLIST_IS_READY:String = "recordListIsReady";
      
      private static var _instance:DailyRecordControl;
       
      
      public var recordList:Vector.<DailiyRecordInfo>;
      
      public function DailyRecordControl()
      {
         super();
         recordList = new Vector.<DailiyRecordInfo>();
         SocketManager.Instance.addEventListener(PkgEvent.format(103),daily);
         ServerManager.Instance.addEventListener("changeServer",__changeServerHandler);
      }
      
      public static function get Instance() : DailyRecordControl
      {
         if(_instance == null)
         {
            _instance = new DailyRecordControl();
         }
         return _instance;
      }
      
      private function __changeServerHandler(param1:Event) : void
      {
         recordList = new Vector.<DailiyRecordInfo>();
      }
      
      private function daily(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = param1.pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new DailiyRecordInfo();
            _loc4_.type = param1.pkg.readInt();
            _loc4_.value = param1.pkg.readUTF();
            if(recordList.length == 0)
            {
               recordList.push(_loc4_);
            }
            else if(isUpdate(_loc4_.type))
            {
               _loc3_ = 0;
               while(_loc3_ < recordList.length)
               {
                  if(recordList[_loc3_].type == _loc4_.type)
                  {
                     recordList[_loc3_].value = _loc4_.value;
                     break;
                  }
                  if(_loc3_ == recordList.length - 1)
                  {
                     sortPos(_loc4_);
                     break;
                  }
                  _loc3_++;
               }
            }
            else
            {
               sortPos(_loc4_);
            }
            _loc5_++;
         }
         dispatchEvent(new Event("recordListIsReady"));
      }
      
      private function sortPos(param1:DailiyRecordInfo) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < recordList.length)
         {
            if(_loc2_ != recordList.length - 1)
            {
               if(param1.type >= recordList[_loc2_].type && param1.type < recordList[_loc2_ + 1].type)
               {
                  recordList.splice(_loc2_ + 1,0,param1);
                  break;
               }
               _loc2_++;
               continue;
            }
            if(param1.type < recordList[_loc2_].type)
            {
               recordList.unshift(param1);
            }
            else
            {
               recordList.push(param1);
            }
            break;
         }
      }
      
      private function isUpdate(param1:int) : Boolean
      {
         var _loc2_:* = param1;
         if(10 !== _loc2_)
         {
            if(16 !== _loc2_)
            {
               if(17 !== _loc2_)
               {
                  if(18 !== _loc2_)
                  {
                     if(19 !== _loc2_)
                     {
                        if(11 !== _loc2_)
                        {
                           if(12 !== _loc2_)
                           {
                              if(13 !== _loc2_)
                              {
                                 if(15 !== _loc2_)
                                 {
                                    if(14 !== _loc2_)
                                    {
                                       if(20 !== _loc2_)
                                       {
                                          if(29 !== _loc2_)
                                          {
                                             if(30 !== _loc2_)
                                             {
                                                return false;
                                             }
                                          }
                                          addr17:
                                          return true;
                                       }
                                       addr16:
                                       §§goto(addr17);
                                    }
                                    addr15:
                                    §§goto(addr16);
                                 }
                                 addr14:
                                 §§goto(addr15);
                              }
                              addr13:
                              §§goto(addr14);
                           }
                           addr12:
                           §§goto(addr13);
                        }
                        addr11:
                        §§goto(addr12);
                     }
                     addr10:
                     §§goto(addr11);
                  }
                  addr9:
                  §§goto(addr10);
               }
               addr8:
               §§goto(addr9);
            }
            addr7:
            §§goto(addr8);
         }
         §§goto(addr7);
      }
      
      public function alertDailyFrame() : void
      {
         SocketManager.Instance.out.sendDailyRecord();
         var _loc1_:DailyRecordFrame = ComponentFactory.Instance.creatComponentByStylename("dailyRecordFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,2);
      }
   }
}
