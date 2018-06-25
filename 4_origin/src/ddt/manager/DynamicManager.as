package ddt.manager
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.action.FrameShowAction;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.view.SNSFrame;
   import flash.external.ExternalInterface;
   import flash.system.Security;
   
   public class DynamicManager
   {
      
      private static var _ins:DynamicManager;
       
      
      public function DynamicManager()
      {
         super();
      }
      
      public static function get Instance() : DynamicManager
      {
         if(_ins == null)
         {
            _ins = new DynamicManager();
         }
         return _ins;
      }
      
      public function initialize() : void
      {
         if(ExternalInterface.available && PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog())
         {
            Security.allowInsecureDomain("*");
            ExternalInterface.addCallback("sinaCallBack",sinaCallBack);
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(39),__getDynamic);
      }
      
      private function __getDynamic(event:PkgEvent) : void
      {
         if(PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog())
         {
            __semdWeiBo(event);
         }
         else
         {
            __sendDynamic(event);
         }
      }
      
      public function __sendDynamic(event:CrazyTankSocketEvent) : void
      {
         var snsFrame:* = null;
         if(SharedManager.Instance.isCommunity)
         {
            snsFrame = ComponentFactory.Instance.creatComponentByStylename("core.SNSFrameView");
            snsFrame.typeId = event.pkg.readInt();
            snsFrame.backgroundServerTxt = event.pkg.readUTF();
            snsFrame.receptionistTxt = event.pkg.readUTF();
            if(CacheSysManager.isLock("alertInFight"))
            {
               CacheSysManager.getInstance().cache("alertInFight",new FrameShowAction(snsFrame));
            }
            else if(CacheSysManager.isLock("alertInMovie"))
            {
               CacheSysManager.getInstance().cache("alertInMovie",new FrameShowAction(snsFrame));
            }
            else
            {
               snsFrame.show();
            }
         }
      }
      
      public function __semdWeiBo(event:CrazyTankSocketEvent) : void
      {
         var imageUrl:* = null;
         if(SharedManager.Instance.allowSnsSend || !PathManager.CommunityExist())
         {
            return;
         }
         var obj2:Object = {};
         var typeId:int = event.pkg.readInt();
         imageUrl = "flash/CMFriendIcon/sinaweibo/weibo" + typeId + ".jpg";
         imageUrl = PathManager.CommunitySinaWeibo(imageUrl);
         obj2.title = event.pkg.readUTF();
         obj2.content = event.pkg.readUTF();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("sendWeiboFeed",obj2.title,obj2.content,imageUrl);
            SocketManager.Instance.out.sendSnsMsg(typeId);
         }
      }
      
      public function sinaCallBack() : void
      {
         ChatManager.Instance.sysChatYellow("微博发送成功!");
         SocketManager.Instance.out.sendSnsMsg(0);
      }
   }
}
