# ssm-Library
我在 GitHub 上的第一个仓库

1：构造器注入
2：Set方式注入
依赖注入：set注入
依赖：bean对象的创建依赖容器
注入：bean对象中所有属性，由容器来注入
3：拓展方式
bean的自动装配：
ByName自动装配
ByType自动装配
注解自动装配

@Component的衍生注解，在web开发中，按照MVC三层架构分层：
Controller层@Controller
Service层@Service
Dao层@Repository
以上四种注解功能都一样，都将类注册到容器（Spring）中，装配Bean

@Scope（可是设置是单例还是原型模式（单一对象，多个对象））

@Autowired和@Resource都是注入


代理模式:静态代理，动态代理—>(反射机制)

反射
（有Class类型的，类，接口，一维数组，二维数组，注解，枚举，基本数据类型，void，Class）
getClass   
getName（获得包+类的名字）
forName
getSimpleName（获得类名）
getMethods（本类及父类全部public方法）
getDeclaredMethods（本类所有方法）

setName.invoke(方法名.invoke激活（对象，传入参数）)

调用（final）常量，父类的静态量，数组不会加载类
类加载器-->上面父类，下面子类
引导类加载器（C，C++编译无法直接获取）
扩展类加载器
系统类加载器

实现aop切面
方式一：原生Spring Api接口
方式二：自定义类切入
方式三：注解切入@Aspect（标注这个类是个切面（类似上面的自定义类））
记得配置spring的<bean>或者
@component   以及Springxml的 <context:component-scan base-package="com"/>和链接配置
开启注解支持<aop:aspectj-autoproxy/>

数据的一致性和完整性
Spring 使用事物来保证，面向切面
