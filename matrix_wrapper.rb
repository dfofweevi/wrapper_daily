# coding:utf-8

require 'matrix'

# 注意矩阵的阶数
# 注意运算单元的类型
# 行号、列号都是从0开始

#### 矩阵生成器 ####

def 矩阵; Matrix; end

def 矩阵行列 行,列=行,&元素范式
  Matrix.build(行,列,&元素范式)
end

def 行向量矩阵 行列表
  raise "请输入行向量数组" unless 行列表.class==Array
  Matrix.rows 行列表 #, 拷贝复制=true
end

def 列向量矩阵 列列表
  raise "请输入列向量数组" unless 列列表.class==Array
  Matrix.columns 列列表
end

#### 特殊矩阵 ####

def 零矩阵 阶数
  Matrix.zero 阶数
end

def 单位矩阵 阶数
  Matrix.identity 阶数
end

def 数量矩阵 阶数,值
  Matrix.scalar 阶数,值
end

def 对角矩阵 *对角元素集合
  Matrix.diagonal *对角元素集合
end

#### 向量 ####

def 行向量 数组
  raise "请输入行向量" unless 数组.class == Array
  Matrix.row_vector 数组
end

def 列向量 数组
  raise "请输入列向量" unless 数组.class == Array
  Matrix.column_vector 数组
end

def 零向量 阶数,行列
  return Matrix.empty(阶数,0) if 行列 == :行
  return Matrix.empty(0,阶数) if 行列 == :列
end

#### 内包装 ####
class Matrix
  #### 基本操作 ####
  def 相等？ 矩阵; eql?(矩阵); end
  def 相等?  矩阵; eql?(矩阵); end
  def 副本; clone; end
  def 文本化; inspect; end # .to_s
  def 数组化; to_a; end # 以行向量的形式构成数组
  def 哈希码; hash; end # 给出该矩阵一个唯一的hash键值
  
  def 小数化; map(&:to_f); end # .elements_to_f()
  def 整数化; map(&:to_i); end # .elements_to_i()
  def 实数化; map(&:to_r); end # .elements_to_r()

  def 运算 &元素范式; collect &元素范式; end # .map
  def 迭代 &元素范式; each &元素范式; end
  def 按行列号迭代 &元素范式; each_with_index &元素范式; end

  def 设置元素 行号,列号,值
    set_element(行号,列号,值) # .set_component(私有方法) .[]=(私有方法)
  end

  def 子矩阵 行范围,列范围# 开始行号..结束行号 开始列号..结束列号
    # 支持负方向选择; 行列标号超过范围将返回nil
    minor 行范围,列范围 # 另一种格式：minor(开始行,行数,开始列,列数)
  end
  
  def 等阶扩展 数值
    coerce 数值# 返回一个首元素是和该矩阵同阶的数值构成的矩阵、次元素是该矩阵自身的数组
  end
  
  #### 基本特征 ####
  def 为空？; empty?; end
  def 为空? ; empty?; end
  
  # [行号,列号] 
  def 元素 行号,列号; element 行号,列号; end # .component
  def 行 行号; row 行号; end
  def 列 列号; column 列号; end
  def 阶数; rank; end # .rank_e
  def 行数; row_size; end
  def 列数; column_size; end

  # +(矩阵) -(矩阵) *(矩阵) /(矩阵) **(幂指数)
  def 转置; t; end # .transpose

  #### 方阵特征 ####
  def 方阵？; square?; end
  def 方阵? ; square?; end
  def 正交矩阵？; regular?; end
  def 正交矩阵? ; regular?; end
  def 标准正交矩阵？; singular?; end
  def 标准正交矩阵? ; singular?; end
  def 迹; tr; end # .trace
  def 行列式值; det; end # .determinant .determinant_bareiss(私有方法)
  def 逆矩阵; inv; end # .inverse

  #### 复数特征 ####
  def 实矩阵？; real?; end
  def 实矩阵? ; real?; end
  def 实矩阵; real; end
  def 虚矩阵; imag; end # .imaginary
  def 复矩阵; rect; end # .rectangular
  def 共轭矩阵; conj; end # .conjugate
  
  #### 额外功能 ####
  def 形式
    max_length = 0;context = ""
    each{|e|max_length = e.to_s.length if e.to_s.length > max_length}
    to_a.each do|row|
      row.each{|data| context << "%#{max_length}s " % data}
      context << "\n"
    end
    return context
  end
end


