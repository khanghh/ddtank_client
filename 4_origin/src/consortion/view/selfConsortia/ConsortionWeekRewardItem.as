package consortion.view.selfConsortia
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaWeekRewardPlayerVo;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ConsortionWeekRewardItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var rankName:Array;
      
      private var _rankText:FilterFrameText;
      
      private var _weekRichesText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _playerInfo:ConsortiaWeekRewardPlayerVo;
      
      private var _itemCell:BaseCell;
      
      private var _bg:Bitmap;
      
      public function ConsortionWeekRewardItem()
      {
         rankName = ["st","nd","rd","th"];
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = UICreatShortcut.creatAndAdd("asset.consortion.weekRewardBg",this);
         _rankText = UICreatShortcut.creatTextAndAdd("consortion.week.itemRank","",this);
         _weekRichesText = UICreatShortcut.creatTextAndAdd("consortion.week.itemText","",this);
         _nameText = UICreatShortcut.creatTextAndAdd("consortion.week.itemText","",this);
         ObjectUtils.copyPropertyByRectangle(_rankText,ComponentFactory.Instance.creatCustomObject("consort.week.rankRec"));
         ObjectUtils.copyPropertyByRectangle(_weekRichesText,ComponentFactory.Instance.creatCustomObject("consort.week.weekRichesRec"));
         ObjectUtils.copyPropertyByRectangle(_nameText,ComponentFactory.Instance.creatCustomObject("consort.week.nameRec"));
         _itemCell = createItemCell();
         PositionUtils.setPos(_itemCell,"consort.week.rewardCellPos");
         addChild(_itemCell);
      }
      
      public function setCellValue(value:*) : void
      {
         var index:int = 0;
         _playerInfo = value;
         if(_playerInfo)
         {
            _nameText.text = _playerInfo.Name;
            _weekRichesText.text = _playerInfo.Rich.toString();
            index = (_playerInfo.Rank < 4?_playerInfo.Rank:4) - 1;
            _rankText.text = _playerInfo.Rank.toString() + rankName[index];
            _itemCell.info = ConsortionModelManager.Instance.model.weekReward[_playerInfo.Rank];
         }
         else
         {
            _nameText.text = "";
            _weekRichesText.text = "";
            _rankText.text = "";
            _itemCell.info = null;
         }
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      private function createItemCell() : BaseCell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,30,30);
         sp.graphics.endFill();
         var cell:BaseCell = new BaseCell(sp,null,true,true);
         CellFactory.instance.fillTipProp(cell);
         return cell;
      }
      
      public function getCellValue() : *
      {
         return _playerInfo;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
