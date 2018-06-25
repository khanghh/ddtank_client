package quest
{
   import bagAndInfo.cell.CellFactory;
   import beadSystem.beadSystemManager;
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   
   public class QuestRewardCell extends Sprite implements Disposeable
   {
       
      
      private const NAME_AREA_HEIGHT:int = 44;
      
      private var quantityTxt:FilterFrameText;
      
      private var nameTxt:FilterFrameText;
      
      private var bgStyle:MutipleImage;
      
      private var shine:Bitmap;
      
      private var item:ShopItemCell;
      
      private var _info:InventoryItemInfo;
      
      public function QuestRewardCell(isShowBg:Boolean = true)
      {
         super();
         if(isShowBg)
         {
            bgStyle = ComponentFactory.Instance.creatComponentByStylename("rewardCell.BGStyle1");
            addChild(bgStyle);
            shine = ComponentFactory.Instance.creat("asset.core.quest.QuestRewardCellBGShine");
            shine.visible = false;
            addChild(shine);
         }
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,43,43);
         sp.graphics.endFill();
         item = CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
         item.cellSize = 40;
         item.x = -1;
         item.y = -1;
         addChild(item);
         quantityTxt = ComponentFactory.Instance.creat("BagCellCountText");
         quantityTxt.x = 38;
         quantityTxt.y = 29;
         addChild(quantityTxt);
         if(isShowBg)
         {
            nameTxt = ComponentFactory.Instance.creat("core.quest.QuestItemRewardName");
            addChild(nameTxt);
         }
         item.addEventListener("mouseOver",__overHandler);
         item.addEventListener("mouseOut",__outHandler);
      }
      
      public function get _shine() : Bitmap
      {
         return shine;
      }
      
      private function __overHandler(event:MouseEvent) : void
      {
         TweenLite.to(item,0.25,{
            "x":-13,
            "y":-14,
            "scaleX":1.5,
            "scaleY":1.5,
            "ease":Quad.easeOut
         });
         TweenLite.to(quantityTxt,0.25,{
            "y":34,
            "alpha":0
         });
      }
      
      private function __outHandler(event:MouseEvent) : void
      {
         TweenLite.to(item,0.25,{
            "x":-1,
            "y":-1,
            "scaleX":1,
            "scaleY":1,
            "ease":Quad.easeOut
         });
         TweenLite.to(quantityTxt,0.25,{
            "y":29,
            "alpha":1
         });
      }
      
      public function set taskType(type:int) : void
      {
      }
      
      public function set opitional(value:Boolean) : void
      {
         if(bgStyle.visible)
         {
            bgStyle.setFrame(!!value?2:1);
         }
      }
      
      public function set info(info:InventoryItemInfo) : void
      {
         if(info == null)
         {
            return;
         }
         item.info = info;
         if(info.Count > 1)
         {
            quantityTxt.text = info.Count.toString();
         }
         else
         {
            quantityTxt.text = "";
         }
         _info = info;
         if(EquipType.isBead(int(info.Property1)))
         {
            itemName = beadSystemManager.Instance.getBeadName(info);
         }
         else
         {
            itemName = info.Name;
         }
      }
      
      public function get info() : InventoryItemInfo
      {
         return _info;
      }
      
      public function __setItemName(e:Event) : void
      {
         if(EquipType.isBead(int(info.Property1)))
         {
            itemName = beadSystemManager.Instance.getBeadName(info);
         }
         else
         {
            itemName = info.Name;
         }
      }
      
      public function set itemName(name:String) : void
      {
         if(nameTxt)
         {
            nameTxt.text = name;
            nameTxt.y = (44 - nameTxt.textHeight) / 2;
         }
      }
      
      public function set selected(value:Boolean) : void
      {
         if(!shine.visible && value)
         {
            SoundManager.instance.play("008");
         }
         shine.visible = value;
         TaskManager.itemAwardSelected = this.info.TemplateID;
      }
      
      public function initSelected() : void
      {
         shine.visible = true;
         TaskManager.itemAwardSelected = this.info.TemplateID;
      }
      
      public function get selected() : Boolean
      {
         return shine.visible;
      }
      
      public function canBeSelected() : void
      {
         this.buttonMode = true;
         addEventListener("click",__selected);
      }
      
      private function __selected(evt:MouseEvent) : void
      {
         dispatchEvent(new RewardSelectedEvent(this));
      }
      
      public function dispose() : void
      {
         _info = null;
         item.removeEventListener("mouseOver",__overHandler);
         item.removeEventListener("mouseOut",__outHandler);
         TweenLite.killTweensOf(item);
         removeEventListener("click",__selected);
         if(quantityTxt)
         {
            ObjectUtils.disposeObject(quantityTxt);
         }
         quantityTxt = null;
         if(nameTxt)
         {
            ObjectUtils.disposeObject(nameTxt);
         }
         nameTxt = null;
         if(bgStyle)
         {
            ObjectUtils.disposeObject(bgStyle);
         }
         bgStyle = null;
         if(shine)
         {
            ObjectUtils.disposeObject(shine);
         }
         shine = null;
         if(item)
         {
            ObjectUtils.disposeObject(item);
         }
         item = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
