package consortiaDomain.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class KillRankCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:Object;
      
      private var _rankTf:FilterFrameText;
      
      private var _playerNameTf:FilterFrameText;
      
      private var _killNumTf:FilterFrameText;
      
      public function KillRankCell()
      {
         super();
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(value:*) : void
      {
         _data = value;
         update();
      }
      
      private function update() : void
      {
         var resIndex:String = Math.min(4,_data.Rank).toString();
         if(!_rankTf)
         {
            _rankTf = UICreatShortcut.creatTextAndAdd("consortiadomain.killRankView.rankItem" + resIndex,"",this);
            PositionUtils.setPos(_rankTf,"consortiadomain.killRankView.item.rankPos");
         }
         _rankTf.text = _data.Rank.toString();
         if(!_playerNameTf)
         {
            _playerNameTf = UICreatShortcut.creatTextAndAdd("consortiadomain.killRankView.rankItem" + resIndex,"",this);
            PositionUtils.setPos(_playerNameTf,"consortiadomain.killRankView.item.playerNamePos");
         }
         _playerNameTf.text = _data.NickName;
         if(!_killNumTf)
         {
            _killNumTf = UICreatShortcut.creatTextAndAdd("consortiadomain.killRankView.rankItem" + resIndex,"",this);
            PositionUtils.setPos(_killNumTf,"consortiadomain.killRankView.item.killNumPos");
         }
         _killNumTf.text = _data.KillCount.toString();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         ObjectUtils.disposeObject(_rankTf);
         _rankTf = null;
         ObjectUtils.disposeObject(_playerNameTf);
         _playerNameTf = null;
         ObjectUtils.disposeObject(_killNumTf);
         _killNumTf = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
