package treasureHunting.views
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.reader.AwardsInfo;
   import ddt.view.caddyII.reader.AwardsItem;
   import ddt.view.tips.CardBoxTipPanel;
   import ddt.view.tips.GoodTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   
   public class TreasureRecordView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      protected var _list:VBox;
      
      protected var _panel:ScrollPanel;
      
      private var _goodTip:GoodTip;
      
      private var _cardTip:CardBoxTipPanel;
      
      private var _itemArr:Array;
      
      private var _isMySelf:Boolean;
      
      private var tempArr:Vector.<AwardsInfo>;
      
      protected var _goodTipPos:Point;
      
      private var _tipStageClickCount:int;
      
      public function TreasureRecordView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      protected function _getAwards(param1:PkgEvent) : void{}
      
      private function _awardsChange(param1:Event) : void{}
      
      public function addItem(param1:AwardsInfo) : void{}
      
      private function _showLinkGoodsInfo(param1:CaddyEvent) : void{}
      
      private function showLinkGoodsInfo(param1:ItemTemplateInfo, param2:uint = 0) : void{}
      
      private function setTipPos(param1:BaseTip) : void{}
      
      private function __stageClickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
