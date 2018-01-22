package firstRecharge.items
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Sprite;
   import gemstone.items.ExpBar;
   
   public class RechargeExpBar extends ExpBar
   {
       
      
      public function RechargeExpBar()
      {
         super();
      }
      
      override public function initView() : void
      {
         _groudPic = ComponentFactory.Instance.creatBitmap("fristRecharge.indu.ground");
         addChild(_groudPic);
         _curPic = ComponentFactory.Instance.creatBitmap("fristRecharge.indu.form");
         addChild(_curPic);
         _expBarTxt = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.expbar.txt");
         _expBarTxt.text = "0";
         addChild(_expBarTxt);
         _maskMC = new Sprite();
         _maskMC.graphics.beginFill(0);
         _maskMC.graphics.drawRect(0,0,_curPic.width,_curPic.height);
         _maskMC.x = 20;
         _maskMC.y = 2;
         _maskMC.graphics.endFill();
         addChild(_maskMC);
         _curPic.mask = _maskMC;
         _oldX = _curPic.x;
      }
   }
}
