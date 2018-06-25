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
      
      public function RedEnvelopeItem(type:int)
      {
         super();
         _type = type;
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
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var conut:int = bagInfo.getItemCountByTemplateId(redList[_type - 1]);
         _redNumTxt.text = "x" + String(conut);
      }
      
      private function __onSelectClick(event:MouseEvent) : void
      {
         select.movie.gotoAndStop(2);
         dispatchEvent(new RedEnvelopeEvent("select",_type));
      }
      
      public function setData() : void
      {
         var award:* = null;
         var i:int = 0;
         var _info:* = null;
         var j:int = 0;
         for(i = 0; i < RedEnvelopeManager.instance.itemInfoList.length; )
         {
            if(RedEnvelopeManager.instance.itemInfoList[i].Quality == _type)
            {
               award = new BagCell(0,null,true,ComponentFactory.Instance.creatBitmap("asset.redEnvelope.cellBg"));
               award.setContentSize(34,34);
               award.x = j * 50;
               award.y = 1;
               _info = new InventoryItemInfo();
               _info.TemplateID = RedEnvelopeManager.instance.itemInfoList[i].TemplateID;
               _info = ItemManager.fill(_info);
               _info.IsBinds = RedEnvelopeManager.instance.itemInfoList[i].IsBind;
               _info.ValidDate = RedEnvelopeManager.instance.itemInfoList[i].ValidDate;
               award.info = _info;
               if(_info.TemplateID == -200)
               {
                  award.setCount(RedEnvelopeManager.instance.itemInfoList[i].Count);
               }
               else
               {
                  award.setCountNotVisible();
               }
               cellBox.addChild(award);
               j++;
            }
            i++;
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
