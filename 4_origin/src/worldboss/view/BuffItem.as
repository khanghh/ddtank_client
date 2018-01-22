package worldboss.view
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Component;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import worldboss.WorldBossManager;
   import worldboss.model.WorldBossBuffInfo;
   
   public class BuffItem extends Component
   {
       
      
      private var _buffId:int;
      
      public function BuffItem(param1:int)
      {
         super();
         _buffId = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:BitmapLoader = LoadResourceManager.Instance.createLoader(WorldBossRoomView.getImagePath(_buffId),0);
         _loc1_.addEventListener("complete",__buffIconComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function __buffIconComplete(param1:LoaderEvent) : void
      {
         var _loc3_:* = null;
         if(param1.loader.isSuccess)
         {
            param1.loader.removeEventListener("complete",__buffIconComplete);
            _loc3_ = param1.loader.content as Bitmap;
            _loc3_.width = 50;
            _loc3_.height = 50;
            addChild(_loc3_);
         }
         tipStyle = "ddt.view.tips.OneLineTip";
         tipDirctions = "5,1";
         var _loc2_:WorldBossBuffInfo = WorldBossManager.Instance.bossInfo.getbuffInfoByID(_buffId);
         tipData = _loc2_.name + ":" + LanguageMgr.GetTranslation("worldboss.buff.limit") + "\n" + _loc2_.decription;
      }
   }
}
