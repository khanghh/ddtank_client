package labyrinth.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import labyrinth.data.RankingInfo;
   
   public class RankingListItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _ranking:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _number:FilterFrameText;
      
      private var _info:RankingInfo;
      
      public function RankingListItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _itemBG = UICreatShortcut.creatAndAdd("labyrinth.RankingListItem.itemBG",this);
         _ranking = UICreatShortcut.creatTextAndAdd("ddt.labyrinth.RankingListItem.text1","1",this);
         _name = UICreatShortcut.creatTextAndAdd("ddt.labyrinth.RankingListItem.text2","大胖子",this);
         _number = UICreatShortcut.creatTextAndAdd("ddt.labyrinth.RankingListItem.text3","23232",this);
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         if(index % 2 != 0)
         {
            _itemBG.setFrame(2);
         }
         else
         {
            _itemBG.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
         _info = value as RankingInfo;
         _ranking.text = _info.PlayerRank.toString();
         _name.text = _info.PlayerName.toString();
         _number.text = _info.FamLevel.toString();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_itemBG);
         _itemBG = null;
         ObjectUtils.disposeObject(_ranking);
         _ranking = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_number);
         _number = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
