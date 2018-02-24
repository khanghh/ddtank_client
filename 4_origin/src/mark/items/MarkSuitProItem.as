package mark.items
{
   import com.pickgliss.ui.text.FilterFrameText;
   import mark.MarkMgr;
   import mark.data.MarkSuitTemplateData;
   import mark.mornUI.items.MarkSuitProItemUI;
   
   public class MarkSuitProItem extends MarkSuitProItemUI
   {
       
      
      public function MarkSuitProItem()
      {
         super();
      }
      
      public function set data(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1)
         {
            _loc3_ = new MarkSuitTemplateData();
            var _loc6_:int = 0;
            var _loc5_:* = MarkMgr.inst.model.cfgSuit;
            for each(var _loc2_ in MarkMgr.inst.model.cfgSuit)
            {
               if(_loc2_.Id == param1.id)
               {
                  _loc3_ = _loc2_;
               }
            }
            chipIcon.gotoAndStop(Math.ceil(_loc3_.Id / 2) - 1);
            _loc4_ = new FilterFrameText();
            _loc4_.htmlText = _loc3_.Explain;
            chipIcon.toolTip = _loc4_.text;
            chipIcon.tipWidth = 400;
            addTypeLabel.text = _loc3_.Name.split("·")[0] + "(" + _loc3_.Name.split("·")[1] + ")";
         }
      }
   }
}
