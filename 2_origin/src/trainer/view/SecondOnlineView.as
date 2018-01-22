package trainer.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class SecondOnlineView extends BaseAlerFrame
   {
       
      
      private var _bmpBg:ScaleBitmapImage;
      
      private var _bmpNpc:Bitmap;
      
      private var _tile:SimpleTileList;
      
      private var _conent1:FilterFrameText;
      
      private var _conent2:FilterFrameText;
      
      private var _conent3:FilterFrameText;
      
      public function SecondOnlineView()
      {
         super();
         addEventListener("response",__responseHandler);
         initView();
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         ObjectUtils.disposeAllChildren(this);
         _tile.dispose();
         _bmpBg = null;
         _bmpNpc = null;
         _tile = null;
         _conent1 = null;
         _conent2 = null;
         _conent3 = null;
         super.dispose();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         info = new AlertInfo();
         _info.showCancel = false;
         _info.moveEnable = false;
         _info.autoButtonGape = false;
         _info.submitLabel = LanguageMgr.GetTranslation("ok");
         _info.customPos = ComponentFactory.Instance.creatCustomObject("trainer.second.posBtn");
         _bmpBg = ComponentFactory.Instance.creatComponentByStylename("trainer.view.SecondOnlineView.bg");
         addToContent(_bmpBg);
         _conent1 = ComponentFactory.Instance.creatComponentByStylename("trainer.view.SecondOnlineView.conentText1");
         _conent1.text = LanguageMgr.GetTranslation("trainer.view.SecondOnlineView.conentText1.text");
         addToContent(_conent1);
         _conent2 = ComponentFactory.Instance.creatComponentByStylename("trainer.view.SecondOnlineView.conentText2");
         _conent2.text = LanguageMgr.GetTranslation("trainer.view.SecondOnlineView.conentText2.text");
         addToContent(_conent2);
         _conent3 = ComponentFactory.Instance.creatComponentByStylename("trainer.view.SecondOnlineView.conentText3");
         _conent3.text = LanguageMgr.GetTranslation("trainer.view.SecondOnlineView.conentText3.text");
         addToContent(_conent3);
         _bmpNpc = ComponentFactory.Instance.creat("asset.trainer.welcome.girl2");
         PositionUtils.setPos(_bmpNpc,"trainer.second.posGirl");
         addToContent(_bmpNpc);
         var _loc5_:Point = ComponentFactory.Instance.creatCustomObject("trainer.posSecondTile");
         var _loc1_:Array = [9003,8003,112097,11998,11901,11233];
         _tile = new SimpleTileList(3);
         _tile.hSpace = 2;
         _tile.vSpace = 2;
         _tile.x = _loc5_.x;
         _tile.y = _loc5_.y;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.ddtcore.goods.cellBg");
            _loc3_ = new BaseCell(_loc2_,ItemManager.Instance.getTemplateById(_loc1_[_loc4_]),true,true);
            _tile.addChild(_loc3_);
            _loc4_++;
         }
         addToContent(_tile);
         ChatManager.Instance.releaseFocus();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            NoviceDataManager.instance.saveNoviceData(730,PathManager.userName(),PathManager.solveRequestPath());
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
   }
}
