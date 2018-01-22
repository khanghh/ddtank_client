package collectionTask.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class TaskProgressItem extends Sprite implements Disposeable
   {
       
      
      private var _nameTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _nameStr:String;
      
      private var _progressStr:String;
      
      public function TaskProgressItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("collectionTask.progressTxt");
         addChild(_nameTxt);
         PositionUtils.setPos(_nameTxt,"task.namePos");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("collectionTask.progressTxt");
         addChild(_progressTxt);
         PositionUtils.setPos(_progressTxt,"task.progressPos");
      }
      
      public function refresh(param1:String) : void
      {
         _nameStr = param1.split(",")[0];
         _progressStr = param1.split(",")[1];
         _nameTxt.text = _nameStr;
         _progressTxt.text = _progressStr;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
