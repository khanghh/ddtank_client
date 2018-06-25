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
         var pos:* = null;
         _background = ComponentFactory.Instance.creatBitmap("asset.game.prop.WeaponBack");
         addChild(_background);
         _cellf = new WeaponPropCell("f",2);
         pos = ComponentFactory.Instance.creatCustomObject("WeaponPropCellPosf");
         _cellf.setPossiton(pos.x,pos.y);
         addChild(_cellf);
         _cellr = new WeaponPropCell("r",2);
         pos = ComponentFactory.Instance.creatCustomObject("WeaponPropCellPosr");
         _cellr.setPossiton(pos.x,pos.y);
         addChild(_cellr);
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = 17200;
         ItemManager.fill(info);
         _cellr.info = new PropInfo(info);
         _cellr.setCount(0);
         _cellr.enabled = true;
      }
      
      private function initEvents() : void
      {
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
         _cellr.addEventListener("click",__cellrClick);
      }
      
      protected function __cellrClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_cellr.enabled)
         {
            SocketManager.Instance.out.useRescueKingBless();
            _cellr.enabled = false;
         }
      }
      
      protected function __keyDown(event:KeyboardEvent) : void
      {
         var _loc2_:* = event.keyCode;
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
      
      public function setKingBlessCount(count:int) : void
      {
         _cellr.setCount(count);
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
