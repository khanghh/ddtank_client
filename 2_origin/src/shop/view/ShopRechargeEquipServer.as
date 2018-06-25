package shop.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ShopRechargeEquipServer extends Sprite implements Disposeable
   {
       
      
      private var _girl:Bitmap;
      
      private var _description:FilterFrameText;
      
      private var _frame:BaseAlerFrame;
      
      public function ShopRechargeEquipServer()
      {
         super();
         _girl = ComponentFactory.Instance.creatBitmap("asset.trainer.welcome.girl2");
         var _loc2_:* = 0.6;
         _girl.scaleY = _loc2_;
         _girl.scaleX = _loc2_;
         PositionUtils.setPos(_girl,"ddtcore.shop.rechargeViewAlert.girlPos");
         _description = ComponentFactory.Instance.creatComponentByStylename("ddtcore.xufei.text");
         _description.text = LanguageMgr.GetTranslation("ddt.shop.rechargeEquipAlert.xufei");
         _frame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.RechargeViewServer");
         var ai:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ok"));
         ai.showCancel = false;
         _frame.info = ai;
         _frame.moveEnable = false;
         _frame.addToContent(_girl);
         _frame.addToContent(_description);
         _frame.addEventListener("response",__frameEventHandler);
      }
      
      private function __frameEventHandler(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(e.responseCode))
         {
            case 0:
            case 1:
               dispose();
            default:
            case 3:
            case 4:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(_frame,2,true,1);
      }
      
      public function dispose() : void
      {
         _frame.dispose();
         _girl = null;
         _description = null;
         _frame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
