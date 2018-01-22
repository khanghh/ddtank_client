package auctionHouse.view
{
   import auctionHouse.event.AuctionHouseEvent;
   import beadSystem.beadSystemManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BaseStripView extends Sprite implements Disposeable
   {
       
      
      protected var _info:AuctionGoodsInfo;
      
      protected var _state:int;
      
      private var _isSelect:Boolean;
      
      private var _cell:AuctionCellViewII;
      
      protected var _name:FilterFrameText;
      
      protected var _count:FilterFrameText;
      
      protected var _leftTime:FilterFrameText;
      
      private var _cleared:Boolean;
      
      protected var stripSelect_bit:Scale9CornerImage;
      
      protected var back_mc:Bitmap;
      
      protected var leftBG:ScaleLeftRightImage;
      
      public function BaseStripView()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _cleared = false;
         back_mc = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.CellBG");
         addChild(back_mc);
         leftBG = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.StripGoodsRightBG");
         addChild(leftBG);
         _name = ComponentFactory.Instance.creat("auctionHouse.BaseStripName");
         addChild(_name);
         _count = ComponentFactory.Instance.creat("auctionHouse.BaseStripCount");
         addChild(_count);
         _leftTime = ComponentFactory.Instance.creat("auctionHouse.BaseStripLeftTime");
         addChild(_leftTime);
         var _loc1_:* = false;
         _leftTime.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _count.mouseEnabled = _loc1_;
         _name.mouseEnabled = _loc1_;
         _cell = new AuctionCellViewII();
         _cell.x = leftBG.x + 2;
         _cell.y = 7;
         addChild(_cell);
         stripSelect_bit = ComponentFactory.Instance.creatComponentByStylename("asset.ddtauction.ListPos1");
         stripSelect_bit.width = 605;
         _loc1_ = false;
         stripSelect_bit.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         stripSelect_bit.mouseChildren = _loc1_;
         stripSelect_bit.visible = _loc1_;
         addChild(stripSelect_bit);
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__over);
         addEventListener("mouseOut",__out);
         addEventListener("click",__click);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__over);
         removeEventListener("mouseOut",__out);
      }
      
      function get info() : AuctionGoodsInfo
      {
         return _info;
      }
      
      function set info(param1:AuctionGoodsInfo) : void
      {
         _info = param1;
         update();
         updateInfo();
      }
      
      function get isSelect() : Boolean
      {
         return _isSelect;
      }
      
      function set isSelect(param1:Boolean) : void
      {
         _isSelect = param1;
         if(_state != 1)
         {
            update();
         }
      }
      
      function clearSelectStrip() : void
      {
         _cleared = true;
         removeEvent();
         _name.text = "";
         _count.text = "";
         _leftTime.text = "";
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         mouseEnabled = false;
         buttonMode = false;
         mouseChildren = false;
         stripSelect_bit.visible = false;
         _isSelect = false;
         _state = 1;
      }
      
      private function update() : void
      {
         if(_cleared)
         {
            initView();
            addEvent();
         }
         stripSelect_bit.visible = !!_isSelect?true:false;
      }
      
      protected function updateInfo() : void
      {
         removeEvent();
         _cell.info = _info.BagItemInfo as ItemTemplateInfo;
         if(EquipType.isBead(int(_cell.info.Property1)))
         {
            _name.text = beadSystemManager.Instance.getBeadName(_cell.itemInfo);
         }
         else
         {
            _name.text = _cell.info.Name;
         }
         _cell.allowDrag = false;
         _count.text = _info.BagItemInfo.Count.toString();
         _leftTime.text = _info.getTimeDescription();
         mouseEnabled = true;
         buttonMode = true;
         addEvent();
      }
      
      override public function set height(param1:Number) : void
      {
      }
      
      private function __over(param1:MouseEvent) : void
      {
         if(_isSelect)
         {
            return;
         }
         stripSelect_bit.visible = true;
      }
      
      private function __out(param1:MouseEvent) : void
      {
         if(_isSelect)
         {
            return;
         }
         stripSelect_bit.visible = false;
      }
      
      private function __click(param1:MouseEvent) : void
      {
         if(!_isSelect)
         {
            SoundManager.instance.play("047");
         }
         isSelect = true;
         dispatchEvent(new AuctionHouseEvent("selectStrip"));
      }
      
      override public function get height() : Number
      {
         return stripSelect_bit.height;
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeEventListener("click",__click);
         if(_info)
         {
            _info = null;
         }
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(back_mc)
         {
            ObjectUtils.disposeObject(back_mc);
         }
         back_mc = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_count)
         {
            ObjectUtils.disposeObject(_count);
         }
         _count = null;
         if(_leftTime)
         {
            ObjectUtils.disposeObject(_leftTime);
         }
         _leftTime = null;
         if(stripSelect_bit)
         {
            ObjectUtils.disposeObject(stripSelect_bit);
         }
         stripSelect_bit = null;
         if(leftBG)
         {
            ObjectUtils.disposeObject(leftBG);
         }
         leftBG = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
