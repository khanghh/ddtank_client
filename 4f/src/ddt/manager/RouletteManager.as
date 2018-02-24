package ddt.manager
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.action.FunctionAction;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.command.QuickBuyFrame;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.caddyII.CaddyAwardListFrame;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyFrame;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.card.CardFrame;
   import ddt.view.caddyII.card.CardSoulBoxFrame;
   import ddt.view.caddyII.vip.VipBoxFrame;
   import ddt.view.roulette.RouletteBoxPanel;
   import ddt.view.roulette.RouletteEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   public class RouletteManager extends EventDispatcher
   {
      
      private static var _instance:RouletteManager = null;
      
      public static const SLEEP:int = 0;
      
      public static const OPEN_ROULETTEBOX:int = 1;
      
      public static const OPEN_CADDY:int = 2;
      
      public static const NO_BOX:int = 0;
      
      public static const ROULETTEBOX:int = 1;
      
      public static const CADDY:int = 2;
       
      
      private var _rouletteBoxkeyCount:int = -1;
      
      private var _caddyKeyCount:int = -1;
      
      private var _templateIDList:Array;
      
      private var _bagType:int;
      
      private var _place:int;
      
      private var _stateAfterBuyKey:int = 0;
      
      private var _boxType:int = 0;
      
      private var _numList:Array;
      
      public var dataList:Vector.<Object>;
      
      public var goodList:Vector.<InventoryItemInfo>;
      
      private var _goodsInfo:ItemTemplateInfo;
      
      private var limdataList:Vector.<Object>;
      
      public function RouletteManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : RouletteManager{return null;}
      
      public function setup() : void{}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      protected function luckStoneRankLimit(param1:PkgEvent) : void{}
      
      private function _showBox(param1:PkgEvent) : void{}
      
      private function _showRoultteView(param1:CrazyTankSocketEvent) : void{}
      
      public function useVipBox(param1:BagCell) : void{}
      
      public function useRouletteBox(param1:BagCell) : void{}
      
      private function updateState() : void{}
      
      public function showRouletteView() : void{}
      
      public function showBuyRouletteKey(param1:int) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function _closeFun() : void{}
      
      private function _randomTemplateID() : void{}
      
      private function _bagUpdate(param1:BagEvent) : void{}
      
      private function __getBadLuckHandler(param1:PkgEvent) : void{}
      
      private function __showBadLuckEndFrame() : void{}
      
      private function getStateAble(param1:String) : Boolean{return false;}
      
      public function useCaddy(param1:BagCell) : void{}
      
      private function _creatCaddy() : void{}
      
      public function useBless(param1:BagCell = null) : void{}
      
      private function _creatBless() : void{}
      
      public function useCelebrationBox() : void{}
      
      public function useBead(param1:int) : void{}
      
      public function useOfferPack(param1:BagCell) : void{}
      
      public function useCard(param1:BagCell) : void{}
      
      private function _loadSWF() : void{}
      
      private function _loadUI() : void{}
      
      private function __onUIComplete(param1:UIModuleEvent) : void{}
      
      private function __onUICompleteOne(param1:UIModuleEvent) : void{}
      
      private function __onSmallLoadingClose(param1:Event) : void{}
      
      private function __onUIProgress(param1:UIModuleEvent) : void{}
   }
}
