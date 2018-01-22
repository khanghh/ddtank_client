package stock.items
{
   import flash.events.MouseEvent;
   import stock.data.StockData;
   import stock.mornUI.items.StockDataItemUI;
   
   public class StockDataItem extends StockDataItemUI
   {
       
      
      private var _data:StockData = null;
      
      private var _overLabels:Array;
      
      private var _normalLabels:Array;
      
      public function StockDataItem()
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
      
      private function overOrOut(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         if(_data == null && param1.type == "click")
         {
            param1.stopImmediatePropagation();
         }
         validLabel();
         var _loc2_:Boolean = param1.type == "mouseOver" || param1.type == "click";
         _loc3_ = 0;
         while(_loc3_ < _overLabels.length)
         {
            _overLabels[_loc3_].visible = _loc2_;
            _normalLabels[_loc3_].visible = !_loc2_;
            _loc3_++;
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
         lblHoldNumSelected.visible = _loc1_;
         lblHoldNum.visible = _loc1_;
         _loc1_ = false;
         lblValidNumSelected.visible = _loc1_;
         lblValidNum.visible = _loc1_;
         _loc1_ = false;
         lblPriceLO.visible = _loc1_;
         _loc1_ = _loc1_;
         lablPriceLN.visible = _loc1_;
         _loc1_ = _loc1_;
         lablPriceGO.visible = _loc1_;
         lablPriceGN.visible = _loc1_;
         _loc1_ = false;
         lblCostLO.visible = _loc1_;
         _loc1_ = _loc1_;
         lblCostLN.visible = _loc1_;
         _loc1_ = _loc1_;
         lblCostGO.visible = _loc1_;
         lblCostGN.visible = _loc1_;
         _loc1_ = false;
         lblFloatBenefitLN.visible = _loc1_;
         _loc1_ = _loc1_;
         lblFloatBenefitLO.visible = _loc1_;
         _loc1_ = _loc1_;
         lblFloatBenefitGN.visible = _loc1_;
         lblFloatBenefitGO.visible = _loc1_;
         _loc1_ = false;
         lblBenefitRateGN.visible = _loc1_;
         _loc1_ = _loc1_;
         lblBenefitRateGO.visible = _loc1_;
         _loc1_ = _loc1_;
         lblBenefitRateLN.visible = _loc1_;
         lblBenefitRateLO.visible = _loc1_;
         if(_data)
         {
            _overLabels.push(lablIDSelected);
            _overLabels.push(lablNameSelected);
            _overLabels.push(lblHoldNumSelected);
            _overLabels.push(lblValidNumSelected);
            _normalLabels.push(lablID);
            _normalLabels.push(lablName);
            _normalLabels.push(lblHoldNum);
            _normalLabels.push(lblValidNum);
            if(_data.floatBenefit >= 0)
            {
               _overLabels.push(lablPriceGO);
               _overLabels.push(lblCostGO);
               _overLabels.push(lblFloatBenefitGO);
               _overLabels.push(lblBenefitRateGO);
               _normalLabels.push(lablPriceGN);
               _normalLabels.push(lblCostGN);
               _normalLabels.push(lblFloatBenefitGN);
               _normalLabels.push(lblBenefitRateGN);
            }
            else
            {
               _overLabels.push(lblPriceLO);
               _overLabels.push(lblCostLO);
               _overLabels.push(lblFloatBenefitLO);
               _overLabels.push(lblBenefitRateLO);
               _normalLabels.push(lablPriceLN);
               _normalLabels.push(lblCostLN);
               _normalLabels.push(lblFloatBenefitLN);
               _normalLabels.push(lblBenefitRateLN);
            }
         }
      }
      
      public function set data(param1:StockData) : void
      {
         var _loc3_:int = 0;
         _data = param1;
         var _loc2_:* = param1 == null;
         var _loc4_:* = !!_loc2_?"":param1.StockID.toString();
         lablIDSelected.text = _loc4_;
         lablID.text = _loc4_;
         _loc4_ = !!_loc2_?"":param1.StockName;
         lablNameSelected.text = _loc4_;
         lablName.text = _loc4_;
         _loc4_ = !!_loc2_?"":param1.holdNum.toString();
         lblHoldNumSelected.text = _loc4_;
         lblHoldNum.text = _loc4_;
         _loc4_ = !!_loc2_?"":param1.validNum.toString();
         lblValidNumSelected.text = _loc4_;
         lblValidNum.text = _loc4_;
         _loc4_ = !!_loc2_?"":param1.price.toString();
         lblPriceLO.text = _loc4_;
         _loc4_ = _loc4_;
         lablPriceLN.text = _loc4_;
         _loc4_ = _loc4_;
         lablPriceGO.text = _loc4_;
         lablPriceGN.text = _loc4_;
         _loc4_ = !!_loc2_?"":param1.cost.toString();
         lblCostLO.text = _loc4_;
         _loc4_ = _loc4_;
         lblCostLN.text = _loc4_;
         _loc4_ = _loc4_;
         lblCostGO.text = _loc4_;
         lblCostGN.text = _loc4_;
         _loc4_ = !!_loc2_?"":param1.floatBenefit.toString();
         lblFloatBenefitLN.text = _loc4_;
         _loc4_ = _loc4_;
         lblFloatBenefitLO.text = _loc4_;
         _loc4_ = _loc4_;
         lblFloatBenefitGN.text = _loc4_;
         lblFloatBenefitGO.text = _loc4_;
         _loc4_ = !!_loc2_?"":(param1.benefitRate * 100).toFixed(2) + "%";
         lblBenefitRateGN.text = _loc4_;
         _loc4_ = _loc4_;
         lblBenefitRateGO.text = _loc4_;
         _loc4_ = _loc4_;
         lblBenefitRateLN.text = _loc4_;
         lblBenefitRateLO.text = _loc4_;
         validLabel();
         _loc3_ = 0;
         while(_loc3_ < _normalLabels.length)
         {
            _normalLabels[_loc3_].visible = true;
            _loc3_++;
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
