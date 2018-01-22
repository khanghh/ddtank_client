package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class QuestDescriptView extends Sprite implements Disposeable
   {
       
      
      private var _descTitle:Bitmap;
      
      private var descText:FilterFrameText;
      
      private var panel:ScrollPanel;
      
      private var container:Sprite;
      
      public function QuestDescriptView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         container = new Sprite();
         _descTitle = ComponentFactory.Instance.creat("asset.core.quest.QuestInfoDescTitle");
         descText = ComponentFactory.Instance.creat("core.quest.QuestInfoDescription");
         panel = ComponentFactory.Instance.creatComponentByStylename("core.quest.QuestDescriptPanel");
         container.addChild(_descTitle);
         container.addChild(descText);
         panel.setView(container);
         addChild(panel);
      }
      
      public function set info(param1:QuestInfo) : void
      {
         descText.htmlText = QuestDescTextAnalyz.start(param1.Detail);
         panel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_descTitle);
         _descTitle = null;
         ObjectUtils.disposeObject(descText);
         descText = null;
         ObjectUtils.disposeObject(panel);
         panel = null;
         ObjectUtils.disposeObject(container);
         container = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
