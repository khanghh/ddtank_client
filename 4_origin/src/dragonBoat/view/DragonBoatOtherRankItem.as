package dragonBoat.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class DragonBoatOtherRankItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:Object;
      
      private var _rankIconList:Vector.<Bitmap>;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:GradientText;
      
      private var _zoneTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _awardHbox:Sprite;
      
      private var _awardList:Vector.<BagCell>;
      
      private var _awardHboxPos:Point;
      
      public function DragonBoatOtherRankItem()
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         super();
         _awardList = new Vector.<BagCell>();
         _rankIconList = new Vector.<Bitmap>(3);
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.cellRankth" + (_loc3_ + 1));
            addChild(_loc1_);
            _rankIconList[_loc3_] = _loc1_;
            _loc3_++;
         }
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.cell.rankTxt");
         _nameTxt = VipController.instance.getVipNameTxt(105,1);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.align = "center";
         _loc2_.bold = true;
         _nameTxt.textField.defaultTextFormat = _loc2_;
         _nameTxt.textSize = 14;
         PositionUtils.setPos(_nameTxt,"dragonBoat.mainFrame.cell.nameTxtPos");
         addChild(_nameTxt);
         _zoneTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.cell.scoreTxt");
         PositionUtils.setPos(_zoneTxt,"dragonBoat.mainFrame.otherCell.zoneTxtPos");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.cell.scoreTxt");
         PositionUtils.setPos(_scoreTxt,"dragonBoat.mainFrame.otherCell.scoreTxtPos");
         _awardHboxPos = ComponentFactory.Instance.creatCustomObject("dragonBoat.shopFrame.cellAwardOtherPos");
         _awardHbox = new Sprite();
         _awardHbox.y = _awardHboxPos.y;
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_zoneTxt);
         addChild(_scoreTxt);
         addChild(_awardHbox);
      }
      
      private function clearAwardCell() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _awardList;
         for each(var _loc1_ in _awardList)
         {
            _loc1_.info = null;
         }
      }
      
      private function updateAwardCell(param1:int, param2:ItemTemplateInfo) : void
      {
         var _loc3_:BagCell = null;
         if(param1 > _awardList.length - 1)
         {
            _loc3_ = new BagCell(1,param2,true,null,false);
            _loc3_.tipGapH = 0;
            _loc3_.tipGapV = 0;
            _loc3_.scaleX = 0.6;
            _loc3_.scaleY = 0.6;
         }
         else
         {
            _loc3_ = _awardList[param1];
         }
         _loc3_.info = param2;
         _loc3_.x = _awardHbox.width + 5;
         _awardHbox.addChild(_loc3_);
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _data = param1;
         var _loc2_:int = _data.rank;
         setRankIconVisible(_loc2_);
         if(_loc2_ >= 1 && _loc2_ <= 3)
         {
            _rankTxt.visible = false;
         }
         else
         {
            _rankTxt.text = _loc2_ + "th";
            _rankTxt.visible = true;
         }
         _nameTxt.text = _data.name;
         _zoneTxt.text = _data.zone;
         _scoreTxt.text = _data.score;
         if(_awardHbox)
         {
            while(_awardHbox.numChildren > 0)
            {
               _awardHbox.removeChild(_awardHbox.getChildAt(0));
            }
         }
         clearAwardCell();
         _loc4_ = 0;
         while(_loc4_ < _data.itemInfoArr.length)
         {
            _loc3_ = _data.itemInfoArr[_loc4_] as InventoryItemInfo;
            updateAwardCell(_loc4_,_loc3_);
            _loc4_++;
         }
         _awardHbox.x = _awardHboxPos.x + (120 - _awardHbox.width) / 2;
      }
      
      private function setRankIconVisible(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _rankIconList.length;
         _loc3_ = 1;
         while(_loc3_ <= _loc2_)
         {
            if(param1 == _loc3_)
            {
               _rankIconList[_loc3_ - 1].visible = true;
            }
            else
            {
               _rankIconList[_loc3_ - 1].visible = false;
            }
            _loc3_++;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         if(_awardHbox)
         {
            ObjectUtils.disposeAllChildren(_awardHbox);
            _awardHbox = null;
         }
         _awardHboxPos = null;
         _awardList = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _rankIconList = null;
         _rankTxt = null;
         _nameTxt = null;
         _zoneTxt = null;
         _scoreTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
