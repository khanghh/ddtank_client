package rescue.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.view.prop.WeaponPropCell;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class RescuePropBar extends Sprite implements Disposeable
   {
       
      
      private var _background:Bitmap;
      
      private var _cellf:WeaponPropCell;
      
      private var _cellr:WeaponPropCell;
      
      public function RescuePropBar()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc2_:* = null;
         _background = ComponentFactory.Instance.creatBitmap("asset.game.prop.WeaponBack");
         addChild(_background);
         _cellf = new WeaponPropCell("f",2);
         _loc2_ = ComponentFactory.Instance.creatCustomObject("WeaponPropCellPosf");
         _cellf.setPossiton(_loc2_.x,_loc2_.y);
         addChild(_cellf);
         _cellr = new WeaponPropCell("r",2);
         _loc2_ = ComponentFactory.Instance.creatCustomObject("WeaponPropCellPosr");
         _cellr.setPossiton(_loc2_.x,_loc2_.y);
         addChild(_cellr);
         var _loc1_:InventoryItemInfo = new InventoryItemInfo();
         _loc1_.TemplateID = 17200;
         ItemManager.fill(_loc1_);
         _cellr.info = new PropInfo(_loc1_);
         _cellr.setCount(0);
         _cellr.enabled = true;
      }
      
      private function initEvents() : void
      {
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
         _cellr.addEventListener("click",__cellrClick);
      }
      
      protected function __cellrClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_cellr.enabled)
         {
            SocketManager.Instance.out.useRescueKingBless();
            _cellr.enabled = false;
         }
      }
      
      protected function __keyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:* = param1.keyCode;
         if(KeyStroke.VK_F.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_R.getCode() === _loc2_)
            {
               if(_cellr.enabled)
               {
                  SocketManager.Instance.out.useRescueKingBless();
                  _cellr.enabled = false;
               }
            }
         }
         else
         {
            doNothing();
         }
      }
      
      private function doNothing() : void
      {
      }
      
      public function setKingBlessEnable() : void
      {
         _cellr.enabled = true;
      }
      
      public function setKingBlessCount(param1:int) : void
      {
         _cellr.setCount(param1);
      }
      
      private function removeEvents() : void
      {
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
         _cellr.removeEventListener("click",__cellrClick);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_background);
         _background = null;
         ObjectUtils.disposeObject(_cellf);
         _cellf = null;
         ObjectUtils.disposeObject(_cellr);
         _cellr = null;
      }
   }
}
