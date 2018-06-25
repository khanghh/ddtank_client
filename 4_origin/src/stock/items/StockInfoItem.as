package stock.items
{
   import flash.events.MouseEvent;
   import stock.data.StockData;
   import stock.mornUI.items.StockInfoItemUI;
   
   public class StockInfoItem extends StockInfoItemUI
   {
       
      
      private var _data:StockData = null;
      
      private var _overLabels:Array;
      
      private var _normalLabels:Array;
      
      public function StockInfoItem()
      {
         _overLabels = [];
         _normalLabels = [];
         super();
      }
      
      override protected function initialize() : void
      {
         addEventListener("mouseOver",overOrOut);
         addEventListener("mouseOut",overOrOut);
         addEventListener("click",overOrOut);
      }
      
      private function overOrOut(event:MouseEvent) : void
      {
         var i:int = 0;
         validLabel();
         var isOver:Boolean = event.type == "mouseOver" || event.type == "click";
         for(i = 0; i < _overLabels.length; )
         {
            _overLabels[i].visible = isOver;
            _normalLabels[i].visible = !isOver;
            i++;
         }
      }
      
      public function set data(value:StockData) : void
      {
         var i:int = 0;
         _data = value;
         var isNull:* = value == null;
         lablID.text = !!isNull?"":value.StockID.toString();
         lablIDSelected.text = !!isNull?"":value.StockID.toString();
         lablName.text = !!isNull?"":value.StockName;
         lablNameSelected.text = !!isNull?"":value.StockName;
         var _loc4_:* = !!isNull?"":value.price.toString();
         lblPriceLO.text = _loc4_;
         _loc4_ = _loc4_;
         lablPriceLN.text = _loc4_;
         _loc4_ = _loc4_;
         lblPriceGO.text = _loc4_;
         lablPriceGN.text = _loc4_;
         _loc4_ = !!isNull?"":value.changeValue < 0?value.changeValue.toString():"+" + value.changeValue;
         lblChangeLO.text = _loc4_;
         _loc4_ = _loc4_;
         lblChangeLN.text = _loc4_;
         _loc4_ = _loc4_;
         lblChangeGO.text = _loc4_;
         lblChangeGN.text = _loc4_;
         _loc4_ = !!isNull?"":value.dealNum.toString();
         lblDealNumLO.text = _loc4_;
         _loc4_ = _loc4_;
         lblDealNumLN.text = _loc4_;
         _loc4_ = _loc4_;
         lblDealNumGO.text = _loc4_;
         lblDealNumGN.text = _loc4_;
         _loc4_ = !!isNull?"":value.holdNum.toString();
         lblHoldNumLO.text = _loc4_;
         _loc4_ = _loc4_;
         lblHoldNumLN.text = _loc4_;
         _loc4_ = _loc4_;
         lblHoldNumGO.text = _loc4_;
         lblHoldNumGN.text = _loc4_;
         validLabel();
         for(i = 0; i < _normalLabels.length; )
         {
            _normalLabels[i].visible = true;
            i++;
         }
      }
      
      private function validLabel() : void
      {
         _overLabels.length = 0;
         _normalLabels.length = 0;
         var _loc1_:* = false;
         lablIDSelected.visible = _loc1_;
         lablID.visible = _loc1_;
         _loc1_ = false;
         lablNameSelected.visible = _loc1_;
         lablName.visible = _loc1_;
         _loc1_ = false;
         lblPriceLO.visible = _loc1_;
         _loc1_ = _loc1_;
         lablPriceLN.visible = _loc1_;
         _loc1_ = _loc1_;
         lblPriceGO.visible = _loc1_;
         lablPriceGN.visible = _loc1_;
         _loc1_ = false;
         lblChangeGN.visible = _loc1_;
         _loc1_ = _loc1_;
         lblChangeLN.visible = _loc1_;
         _loc1_ = _loc1_;
         lblChangeGO.visible = _loc1_;
         lblChangeGN.visible = _loc1_;
         _loc1_ = false;
         lblDealNumLO.visible = _loc1_;
         _loc1_ = _loc1_;
         lblDealNumLN.visible = _loc1_;
         _loc1_ = _loc1_;
         lblDealNumGO.visible = _loc1_;
         lblDealNumGN.visible = _loc1_;
         _loc1_ = false;
         lblHoldNumGO.visible = _loc1_;
         _loc1_ = _loc1_;
         lblHoldNumLN.visible = _loc1_;
         _loc1_ = _loc1_;
         lblHoldNumGO.visible = _loc1_;
         lblHoldNumGN.visible = _loc1_;
         if(_data)
         {
            _overLabels.push(lablIDSelected);
            _overLabels.push(lablNameSelected);
            _normalLabels.push(lablID);
            _normalLabels.push(lablName);
            if(_data.changeValue >= 0)
            {
               _overLabels.push(lblPriceGO);
               _overLabels.push(lblChangeGO);
               _overLabels.push(lblDealNumGO);
               _overLabels.push(lblHoldNumGO);
               _normalLabels.push(lablPriceGN);
               _normalLabels.push(lblChangeGN);
               _normalLabels.push(lblDealNumGN);
               _normalLabels.push(lblHoldNumGN);
            }
            else
            {
               _overLabels.push(lblPriceLO);
               _overLabels.push(lblChangeLO);
               _overLabels.push(lblDealNumLO);
               _overLabels.push(lblHoldNumLO);
               _normalLabels.push(lablPriceLN);
               _normalLabels.push(lblChangeLN);
               _normalLabels.push(lblDealNumLN);
               _normalLabels.push(lblHoldNumLN);
            }
         }
      }
      
      public function get data() : StockData
      {
         return _data;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _overLabels.length = 0;
         _overLabels = null;
         _normalLabels.length = 0;
         _normalLabels = null;
         super.dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",overOrOut);
         removeEventListener("mouseOut",overOrOut);
         removeEventListener("click",overOrOut);
      }
   }
}
