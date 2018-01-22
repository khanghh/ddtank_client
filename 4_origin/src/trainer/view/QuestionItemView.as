package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class QuestionItemView extends Sprite implements Disposeable
   {
       
      
      private var _bmpSel:Bitmap;
      
      private var _imgIcon:ScaleFrameImage;
      
      private var _txtContext:FilterFrameText;
      
      private var _index:int;
      
      private var _filters:Vector.<Array>;
      
      public function QuestionItemView()
      {
         super();
         initView();
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function setData(param1:int, param2:String) : void
      {
         _index = param1;
         _imgIcon.setFrame(_index);
         _txtContext.text = param2;
      }
      
      private function initView() : void
      {
         mouseChildren = false;
         buttonMode = true;
         addEventListener("rollOver",__mouseHandler);
         addEventListener("rollOut",__mouseHandler);
         addEventListener("mouseDown",__mouseHandler);
         addEventListener("mouseUp",__mouseHandler);
         _filters = new Vector.<Array>();
         _filters.push([ComponentFactory.Instance.model.getSet("lightFilter")]);
         _filters.push([ComponentFactory.Instance.model.getSet("trainer.question.redFilter")]);
         _bmpSel = ComponentFactory.Instance.creatBitmap("asset.trainer.question.sel");
         addChild(_bmpSel);
         _imgIcon = ComponentFactory.Instance.creat("trainer.question.icon");
         addChild(_imgIcon);
         _txtContext = ComponentFactory.Instance.creat("trainer.question.context");
         addChild(_txtContext);
      }
      
      private function __mouseHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.type;
         if("rollOver" !== _loc2_)
         {
            if("mouseUp" !== _loc2_)
            {
               if("mouseDown" !== _loc2_)
               {
                  if("rollOut" === _loc2_)
                  {
                     filters = null;
                  }
               }
               else
               {
                  filters = _filters[1];
               }
            }
            addr41:
            return;
         }
         filters = _filters[0];
         §§goto(addr41);
      }
      
      public function dispose() : void
      {
         removeEventListener("rollOver",__mouseHandler);
         removeEventListener("rollOut",__mouseHandler);
         removeEventListener("mouseDown",__mouseHandler);
         removeEventListener("mouseUp",__mouseHandler);
         ObjectUtils.disposeAllChildren(this);
         _bmpSel = null;
         _imgIcon = null;
         _txtContext = null;
         _filters = null;
         filters = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
