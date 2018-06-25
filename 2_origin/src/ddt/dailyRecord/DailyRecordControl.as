package ddt.dailyRecord
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.handler;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import ddt.view.chat.ChatData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.setTimeout;
   import road7th.comm.PackageIn;
   
   public class DailyRecordControl extends EventDispatcher
   {
      
      public static const RECORDLIST_IS_READY:String = "recordListIsReady";
      
      private static var _instance:DailyRecordControl;
       
      
      public var recordList:Vector.<DailiyRecordInfo>;
      
      public function DailyRecordControl()
      {
         super();
      }
      
      public static function get Instance() : DailyRecordControl
      {
         if(_instance == null)
         {
            _instance = new DailyRecordControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         recordList = new Vector.<DailiyRecordInfo>();
         SocketManager.Instance.addEventListener(PkgEvent.format(103,1),daily);
         SocketManager.Instance.addEventListener(PkgEvent.format(103,2),SingleLogHandler);
         ServerManager.Instance.addEventListener("changeServer",__changeServerHandler);
      }
      
      private function SingleLogHandler(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var type:int = pkg.readInt();
         var value:String = pkg.readUTF();
         var chatData:ChatData = new ChatData();
         chatData.channel = 21;
         chatData.childChannelArr = [7,14];
         chatData.type = type;
         chatData.msg = LanguageMgr.GetTranslation("ddt.dailyRecord.chatMsg" + type,value);
      }
      
      private function __changeServerHandler(event:Event) : void
      {
         recordList = new Vector.<DailiyRecordInfo>();
      }
      
      private function daily(event:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         var len:int = event.pkg.readInt();
         for(i = 0; i < len; )
         {
            info = new DailiyRecordInfo();
            info.type = event.pkg.readInt();
            info.value = event.pkg.readUTF();
            if(recordList.length == 0)
            {
               recordList.push(info);
            }
            else if(isUpdate(info.type))
            {
               for(j = 0; j < recordList.length; )
               {
                  if(recordList[j].type == info.type)
                  {
                     recordList[j].value = info.value;
                     break;
                  }
                  if(j == recordList.length - 1)
                  {
                     sortPos(info);
                     break;
                  }
                  j++;
               }
            }
            else
            {
               sortPos(info);
            }
            i++;
         }
         dispatchEvent(new Event("recordListIsReady"));
      }
      
      private function sortPos(info:DailiyRecordInfo) : void
      {
         var i:int = 0;
         for(i = 0; i < recordList.length; )
         {
            if(i != recordList.length - 1)
            {
               if(info.type >= recordList[i].type && info.type < recordList[i + 1].type)
               {
                  recordList.splice(i + 1,0,info);
                  break;
               }
               i++;
               continue;
            }
            if(info.type < recordList[i].type)
            {
               recordList.unshift(info);
            }
            else
            {
               recordList.push(info);
            }
            break;
         }
      }
      
      private function isUpdate(type:int) : Boolean
      {
         var _loc2_:* = type;
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
         §§goto(addr10);
      }
      
      public function alertDailyFrame() : void
      {
         SocketManager.Instance.out.sendDailyRecord();
         var dailyFrame:DailyRecordFrame = ComponentFactory.Instance.creatComponentByStylename("dailyRecordFrame");
         LayerManager.Instance.addToLayer(dailyFrame,3,true,2);
      }
   }
}
