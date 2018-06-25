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
      
      public function set data(value:Object) : void
      {
         var suit:* = null;
         var setId:int = 0;
         var txt:* = null;
         if(value)
         {
            suit = new MarkSuitTemplateData();
            var _loc7_:int = 0;
            var _loc6_:* = MarkMgr.inst.model.cfgSuit;
            for each(var it in MarkMgr.inst.model.cfgSuit)
            {
               if(it.Id == value.id)
               {
                  suit = it;
               }
            }
            setId = suit.SetId % 1000;
            chipIcon.gotoAndStop(setId - 1);
            txt = new FilterFrameText();
            txt.htmlText = suit.Explain;
            chipIcon.toolTip = txt.text;
            chipIcon.tipWidth = 400;
            addTypeLabel.text = suit.Name.split("·")[0] + "(" + suit.Name.split("·")[1] + ")";
         }
      }
   }
}
