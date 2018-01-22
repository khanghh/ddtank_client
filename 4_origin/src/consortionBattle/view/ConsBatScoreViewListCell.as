package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ConsBatScoreViewListCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:Object;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      public function ConsBatScoreViewListCell()
      {
         super();
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.scoreView.cellTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.scoreView.cellTxt");
         PositionUtils.setPos(_scoreTxt,"consortiaBattle.scoreView.cellScoreTxtPos");
         addChild(_nameTxt);
         addChild(_scoreTxt);
      }
      
      private function update() : void
      {
         var _loc1_:* = 0;
         _nameTxt.text = _data.rank + "." + _data.name;
         _scoreTxt.text = _data.score;
         var _loc2_:* = _data.rank;
         if(1 !== _loc2_)
         {
            if(2 !== _loc2_)
            {
               if(3 !== _loc2_)
               {
                  _loc1_ = uint(16777215);
               }
               else
               {
                  _loc1_ = uint(1292038);
               }
            }
            else
            {
               _loc1_ = uint(967126);
            }
         }
         else
         {
            _loc1_ = uint(16775296);
         }
         _nameTxt.textColor = _loc1_;
         _scoreTxt.textColor = _loc1_;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1;
         update();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _nameTxt = null;
         _scoreTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
