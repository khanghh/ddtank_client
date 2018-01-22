package vip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class VipPrivilegeTxt extends Sprite implements Disposeable
   {
       
      
      private var _content:TextArea;
      
      public function VipPrivilegeTxt()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _content = ComponentFactory.Instance.creatComponentByStylename("VipPrivilegeLV.propArea");
         addChild(_content);
      }
      
      public function set AlertContent(param1:int) : void
      {
         _content.setView(getAlerTxt(param1));
         _content.invalidateViewport();
      }
      
      private function getAlerTxt(param1:int) : MovieImage
      {
         var _loc2_:MovieImage = new MovieImage();
         switch(int(param1) - 1)
         {
            case 0:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt1");
               break;
            case 1:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt2");
               break;
            case 2:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt3");
               break;
            case 3:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt4");
               break;
            case 4:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt5");
               break;
            case 5:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt6");
               break;
            case 6:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt7");
               break;
            case 7:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt8");
               break;
            case 8:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt9");
               break;
            case 9:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt10");
               break;
            case 10:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt11");
               break;
            case 11:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtvip.PrivilegeTxt12");
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
            _content = null;
         }
      }
   }
}
