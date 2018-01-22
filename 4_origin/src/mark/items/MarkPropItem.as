package mark.items
{
   import mark.MarkMgr;
   import mark.data.MarkProData;
   import mark.mornUI.items.MarkPropItemUI;
   
   public class MarkPropItem extends MarkPropItemUI
   {
       
      
      public function MarkPropItem()
      {
         super();
         maxTxt.visible = false;
      }
      
      public function set enable(param1:Boolean) : void
      {
         radio.selected = param1;
      }
      
      public function get enable() : Boolean
      {
         return radio.selected;
      }
      
      public function set label(param1:String) : void
      {
         radioTxt.htmlText = param1;
      }
      
      public function set markProData(param1:MarkProData) : void
      {
         maxTxt.visible = MarkMgr.inst.model.proIsMax(param1);
      }
   }
}
