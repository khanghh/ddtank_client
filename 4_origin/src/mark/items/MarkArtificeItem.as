package mark.items
{
   import ddt.manager.LanguageMgr;
   import mark.MarkMgr;
   import mark.data.MarkProData;
   import mark.mornUI.items.MarkArtificeItemUI;
   
   public class MarkArtificeItem extends MarkArtificeItemUI
   {
       
      
      public function MarkArtificeItem()
      {
         super();
         maxTxt.visible = false;
      }
      
      public function set data(param1:MarkProData) : void
      {
         if(param1 == null)
         {
            imgWhat.visible = true;
            clipBg.index = 0;
            lblPro.visible = false;
            maxTxt.visible = false;
         }
         else
         {
            lblPro.visible = true;
            imgWhat.visible = false;
            lblPro.text = LanguageMgr.GetTranslation("mark.property",LanguageMgr.GetTranslation("mark.pro" + param1.type),param1.value + param1.attachValue);
            maxTxt.visible = MarkMgr.inst.model.proIsMax(param1);
         }
      }
   }
}
