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
      
      private function __getDynamic(param1:PkgEvent) : void
      {
         if(PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog())
         {
            __semdWeiBo(param1);
         }
         else
         {
            __sendDynamic(param1);
         }
      }
      
      public function __sendDynamic(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         if(SharedManager.Instance.isCommunity)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.SNSFrameView");
            _loc2_.typeId = param1.pkg.readInt();
            _loc2_.backgroundServerTxt = param1.pkg.readUTF();
            _loc2_.receptionistTxt = param1.pkg.readUTF();
            if(CacheSysManager.isLock("alertInFight"))
            {
               CacheSysManager.getInstance().cache("alertInFight",new FrameShowAction(_loc2_));
            }
            else if(CacheSysManager.isLock("alertInMovie"))
            {
               CacheSysManager.getInstance().cache("alertInMovie",new FrameShowAction(_loc2_));
            }
            else
            {
               _loc2_.show();
            }
         }
      }
      
      public function __semdWeiBo(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         if(SharedManager.Instance.allowSnsSend || !PathManager.CommunityExist())
         {
            return;
         }
         var _loc3_:Object = {};
         var _loc4_:int = param1.pkg.readInt();
         _loc2_ = "flash/CMFriendIcon/sinaweibo/weibo" + _loc4_ + ".jpg";
         _loc2_ = PathManager.CommunitySinaWeibo(_loc2_);
         _loc3_.title = param1.pkg.readUTF();
         _loc3_.content = param1.pkg.readUTF();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("sendWeiboFeed",_loc3_.title,_loc3_.content,_loc2_);
            SocketManager.Instance.out.sendSnsMsg(_loc4_);
         }
      }
      
      public function sinaCallBack() : void
      {
         ChatManager.Instance.sysChatYellow("微博发送成功!");
         SocketManager.Instance.out.sendSnsMsg(0);
      }
   }
}
