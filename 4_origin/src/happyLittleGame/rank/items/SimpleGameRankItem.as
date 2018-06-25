package happyLittleGame.rank.items
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import uiModeManager.bombUI.model.rank.HappyMiniGameRankData;
   
   public class SimpleGameRankItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _index:uint;
      
      private var _topThreeIcon:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _playerNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _itemCell:BaseCell;
      
      private var _shine:Scale9CornerImage;
      
      public function SimpleGameRankItem(index:uint)
      {
         super();
         this._index = index;
         this.initItem();
      }
      
      private function initItem() : void
      {
         this._bg = ComponentFactory.Instance.creatComponentByStylename("simpleGameRank.rankItemBg");
         this.addChild(this._bg);
         this._bg.setFrame(this._index % 2 + 1);
         this._topThreeIcon = ComponentFactory.Instance.creat("simpleGameRank.frame.topThree");
         this.addChild(this._topThreeIcon);
         PositionUtils.setPos(this._topThreeIcon,"happygame.itemRank.pos");
         this._topThreeIcon.visible = false;
         this._rankTxt = ComponentFactory.Instance.creat("simpleGameRank.rankText");
         this.addChild(this._rankTxt);
         this._rankTxt.visible = false;
         this._playerNameTxt = ComponentFactory.Instance.creat("simpleGameRank.playerNameText");
         this.addChild(this._playerNameTxt);
         this._serverNameTxt = ComponentFactory.Instance.creat("simpleGameRank.serverNameText");
         this.addChild(this._serverNameTxt);
         this._scoreTxt = ComponentFactory.Instance.creat("simpleGameRank.scoreText");
         this.addChild(this._scoreTxt);
         this._itemCell = createItemCell();
         PositionUtils.setPos(_itemCell,"happygame.rankGift.pos");
         this.addChild(_itemCell);
         this._shine = ComponentFactory.Instance.creat("simpleGameRank.shine");
         this.addChild(this._shine);
         this._shine.visible = false;
         this._shine.mouseEnabled = false;
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
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(this._bg);
         this._bg = null;
         ObjectUtils.disposeObject(this._topThreeIcon);
         this._topThreeIcon = null;
         ObjectUtils.disposeObject(this._shine);
         this._shine = null;
         ObjectUtils.disposeObject(this._itemCell);
         this._itemCell = null;
      }
      
      public function clear() : void
      {
         this._topThreeIcon.visible = false;
         this._rankTxt.text = "";
         this._playerNameTxt.text = "";
         this._serverNameTxt.text = "";
         this._scoreTxt.text = "";
         this._itemCell.info = null;
         this._shine.visible = false;
      }
      
      public function set data(value:HappyMiniGameRankData) : void
      {
         if(!value)
         {
            return;
         }
         this._itemCell.info = value.itemInfo;
         if(value.rank < _topThreeIcon.totalFrames)
         {
            this._topThreeIcon.visible = true;
            this._topThreeIcon.setFrame(value.rank + 1);
            this._rankTxt.visible = false;
         }
         else
         {
            this._rankTxt.visible = true;
            this._rankTxt.text = (value.rank + 1).toString();
            this._topThreeIcon.visible = false;
         }
         this._playerNameTxt.text = value.playerName;
         this._serverNameTxt.text = value.serverName;
         this._scoreTxt.text = value.score.toString();
         this._shine.visible = PlayerManager.Instance.Self.NickName == value.playerName;
      }
   }
}
