package ddQiYuan.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanController;
   import ddQiYuan.DDQiYuanManager;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class DDQiYuanFrame extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _btnHelp:BaseButton;
      
      private var _towerEnterBtn:MovieClip;
      
      private var _gouYuNumTf:FilterFrameText;
      
      private var _treasureKeyNumTf:FilterFrameText;
      
      private var _treasureBoxNumTf:FilterFrameText;
      
      private var _progressMc:MovieClip;
      
      private var _progressBgMc:MovieClip;
      
      private var _activedBaoZhuNumTf:FilterFrameText;
      
      private var _showGetBtn:SimpleBitmapButton;
      
      private var _hasGetGoodsList:HasGetGoodsList;
      
      private var _offerProgressTf:FilterFrameText;
      
      private var _offer1TimeBtn:BaseButton;
      
      private var _offer10TimeBtn:BaseButton;
      
      private var _selectedCheckButton:SelectedCheckButton;
      
      private var _openTreasureBoxBtn:SimpleBitmapButton;
      
      private var _offerRewardGoodsScrollPanel:ScrollPanel;
      
      private var _treasureBoxGoodsScrollPanel:ScrollPanel;
      
      private var _offerRewardGoodsScrollPanelLeftBtn:SimpleBitmapButton;
      
      private var _offerRewardGoodsScrollPanelRightBtn:SimpleBitmapButton;
      
      private var _treasureBoxGoodsScrollPanelLeftBtn:SimpleBitmapButton;
      
      private var _treasureBoxGoodsScrollPanelRightBtn:SimpleBitmapButton;
      
      private var _rankSp:AreaRankSp;
      
      private var _beliefRewardSp:BeliefRewardSp;
      
      private var _model:DDQiYuanModel;
      
      private var _boGuAni:BoGuAni;
      
      private var _joinBagCellSp:JoinBagCellSp;
      
      public function DDQiYuanFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function update() : void{}
      
      private function onBtnClick(param1:MouseEvent) : void{}
      
      private function onChangeTpye(param1:Event) : void{}
      
      private function lockBtns(param1:Boolean) : void{}
      
      private function onOpStart(param1:Event) : void{}
      
      private function onOpBack(param1:CEvent) : void{}
      
      private function responseHandler(param1:FrameEvent) : void{}
      
      private function __onselectedCheckButtoClick(param1:MouseEvent) : void{}
      
      private function setButtonFrame(param1:BaseButton, param2:int) : void{}
      
      private function getButtonCurrentFrame(param1:BaseButton) : int{return 0;}
      
      override public function dispose() : void{}
   }
}
