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
      
      public function BuffItem(id:int)
      {
         super();
         _buffId = id;
         initView();
      }
      
      private function initView() : void
      {
         var buffIconLoader:BitmapLoader = LoadResourceManager.Instance.createLoader(WorldBossRoomView.getImagePath(_buffId),0);
         buffIconLoader.addEventListener("complete",__buffIconComplete);
         LoadResourceManager.Instance.startLoad(buffIconLoader);
      }
      
      private function __buffIconComplete(evt:LoaderEvent) : void
      {
         var buffBitmap:* = null;
         if(evt.loader.isSuccess)
         {
            evt.loader.removeEventListener("complete",__buffIconComplete);
            buffBitmap = evt.loader.content as Bitmap;
            buffBitmap.width = 50;
            buffBitmap.height = 50;
            addChild(buffBitmap);
         }
         tipStyle = "ddt.view.tips.OneLineTip";
         tipDirctions = "5,1";
         var buffInfo:WorldBossBuffInfo = WorldBossManager.Instance.bossInfo.getbuffInfoByID(_buffId);
         tipData = buffInfo.name + ":" + LanguageMgr.GetTranslation("worldboss.buff.limit") + "\n" + buffInfo.decription;
      }
   }
}
