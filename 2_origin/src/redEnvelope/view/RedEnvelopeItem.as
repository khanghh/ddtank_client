package redEnvelope.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import redEnvelope.RedEnvelopeManager;
   import redEnvelope.event.RedEnvelopeEvent;
   
   public class RedEnvelopeItem extends Sprite
   {
      
      public static var redList:Array = [29996,29997,29998,29999];
      
      public static var redcolorList:Array = ["#bababa","#4ee231","#46f0fb","#ffea00"];
       
      
      private var _redNumTxt:FilterFrameText;
      
      public var _type:int;
      
      private var cellBox:Sprite;
      
      public var select:MovieImage;
      
      private var redCell:BagCell;
      
      public function RedEnvelopeItem(param1:int)
      {
         super();
         _type = param1;
         init();
      }
      
      private function init() : void
      {
         _redNumTxt = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.redNumTxt");
         addChild(_redNumTxt);
         updataRedNum();
         cellBox = new Sprite();
         PositionUtils.setPos(cellBox,"asset.redEnvelope.celBoxPos");
         addChild(cellBox);
         redCell = new BagCell(0,null,true,null);
         redCell.BGVisible = false;
         redCell.setContentSize(42,42);
         redCell.info = ItemManager.Instance.getTemplateById(redList[_type - 1]);
         addChild(redCell);
         PositionUtils.setPos(redCell,"asset.redEnvelope.redCellPos");
         select = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.selectMovie");
         select.buttonMode = true;
         select.movie.gotoAndStop(1);
         select.addEventListener("click",__onSelectClick);
         addChild(select);
         setData();
      }
      
      public function updataRedNum() : void
      {
         var _loc1_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var _loc2_:int = _loc1_.getItemCountByTemplateId(redList[_type - 1]);
         _redNumTxt.text = "x" + String(_loc2_);
      }
      
      private function __onSelectClick(param1:MouseEvent) : void
      {
         select.movie.gotoAndStop(2);
         dispatchEvent(new RedEnvelopeEvent("select",_type));
      }
      
      public function setData() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < RedEnvelopeManager.instance.itemInfoList.length)
         {
            if(RedEnvelopeManager.instance.itemInfoList[_loc4_].Quality == _type)
            {
               _loc1_ = new BagCell(0,null,true,ComponentFactory.Instance.creatBitmap("asset.redEnvelope.cellBg"));
               _loc1_.setContentSize(34,34);
               _loc1_.x = _loc2_ * 50;
               _loc1_.y = 1;
               _loc3_ = new InventoryItemInfo();
               _loc3_.TemplateID = RedEnvelopeManager.instance.itemInfoList[_loc4_].TemplateID;
               _loc3_ = ItemManager.fill(_loc3_);
               _loc3_.IsBinds = RedEnvelopeManager.instance.itemInfoList[_loc4_].IsBind;
               _loc3_.ValidDate = RedEnvelopeManager.instance.itemInfoList[_loc4_].ValidDate;
               _loc1_.info = _loc3_;
               if(_loc3_.TemplateID == -200)
               {
                  _loc1_.setCount(RedEnvelopeManager.instance.itemInfoList[_loc4_].Count);
               }
               else
               {
                  _loc1_.setCountNotVisible();
               }
               cellBox.addChild(_loc1_);
               _loc2_++;
            }
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         if(_redNumTxt)
         {
            ObjectUtils.disposeObject(_redNumTxt);
         }
         _redNumTxt = null;
         if(cellBox)
         {
            ObjectUtils.disposeObject(cellBox);
         }
         cellBox = null;
         if(select)
         {
            select.removeEventListener("click",__onSelectClick);
            ObjectUtils.disposeObject(select);
            select = null;
         }
      }
   }
}
