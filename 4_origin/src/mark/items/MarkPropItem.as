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
      
      public function set enable(value:Boolean) : void
      {
         radio.selected = value;
      }
      
      public function get enable() : Boolean
      {
         return radio.selected;
      }
      
      public function set label(value:String) : void
      {
         radioTxt.htmlText = value;
      }
      
      public function set markProData(data:MarkProData) : void
      {
         maxTxt.visible = MarkMgr.inst.model.proIsMax(data);
      }
   }
}
