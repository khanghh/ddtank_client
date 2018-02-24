package ddt.view.caddyII.reader
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.tips.CardBoxTipPanel;
   import ddt.view.tips.GoodTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   
   public class BlessReadAwardsView extends Sprite implements Disposeable, CaddyUpdate
   {
       
      
      private var _bg1:ScaleBitmapImage;
      
      protected var _bg2:MovieImage;
      
      private var _node:Bitmap;
      
      protected var _list:VBox;
      
      protected var _panel:ScrollPanel;
      
      private var _goodTip:GoodTip;
      
      private var _cardTip:CardBoxTipPanel;
      
      protected var _goodTipPos:Point;
      
      private var _tipStageClickCount:int;
      
      private var _isMySelf:Boolean;
      
      private var tempArr:Vector.<AwardsInfo>;
      
      public function BlessReadAwardsView(){super();}
      
      protected function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function requestAwards() : void{}
      
      private function _getAwards(param1:PkgEvent) : void{}
      
      private function removeListChildEvent() : void{}
      
      private function _awardsChange(param1:Event) : void{}
      
      private function _showLinkGoodsInfo(param1:CaddyEvent) : void{}
      
      private function showLinkGoodsInfo(param1:ItemTemplateInfo, param2:uint = 0) : void{}
      
      private function setTipPos(param1:BaseTip) : void{}
      
      private function __stageClickHandler(param1:MouseEvent) : void{}
      
      public function addItem(param1:AwardsInfo) : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
