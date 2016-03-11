class CreateCertificateRequest
  constructor: (@product, @years, @csr, @dcvType) ->
    @subjectAlternativeNames = []
    @dcv = []
    @company = ''
    @department = ''
    @address = ''
    @zipcode = ''
    @city = ''
    @approverFirstName = ''
    @approverLastName = ''
    @approverEmail = ''
    @approverPhone = ''
    @kvk = ''
    @reference = ''

  toArray: () =>
    result = {
      product: @product,
      years: @years,
      csr: @csr,
      dcvType: @dcvType
    }

    result['subjectAlternativeNames'] = @subjectAlternativeNames.join(',') if @subjectAlternativeNames.length > 0
    result['dcv'] = JSON.stringify(@dcv) if @dcv.length > 0
    result['company'] = @company if @company != ''
    result['department'] = @department if @department != ''
    result['address'] = @address if @address != ''
    result['zipcode'] = @zipcode if @zipcode != ''
    result['city'] = @city if @city != ''
    result['approverFirstName'] = @approverFirstName if @approverFirstName != ''
    result['approverLastName'] = @approverLastName if @approverLastName != ''
    result['approverEmail'] = @approverEmail if @approverEmail != ''
    result['approverPhone'] = @approverPhone if @approverPhone != ''
    result['kvk'] = @kvk if @kvk != ''
    result['reference'] = @reference if @reference != ''

    result

class ReissueCertificateRequest
  constructor: (@csr, @dcvType) ->
    @subjectAlternativeNames = []
    @dcv = []
    @company = ''
    @department = ''
    @address = ''
    @zipcode = ''
    @city = ''
    @approverFirstName = ''
    @approverLastName = ''
    @approverEmail = ''
    @approverPhone = ''
    @kvk = ''
    @reference = ''

  toArray: () =>
    result = {
      csr: @csr,
      dcvType: @dcvType
    }

    result['subjectAlternativeNames'] = @subjectAlternativeNames.join(',') if @subjectAlternativeNames.length > 0
    result['dcv'] = JSON.stringify(@dcv) if @dcv.length > 0
    result['company'] = @company if @company != ''
    result['department'] = @department if @department != ''
    result['address'] = @address if @address != ''
    result['zipcode'] = @zipcode if @zipcode != ''
    result['city'] = @city if @city != ''
    result['approverFirstName'] = @approverFirstName if @approverFirstName != ''
    result['approverLastName'] = @approverLastName if @approverLastName != ''
    result['approverEmail'] = @approverEmail if @approverEmail != ''
    result['approverPhone'] = @approverPhone if @approverPhone != ''
    result['kvk'] = @kvk if @kvk != ''
    result['reference'] = @reference if @reference != ''

    result

class RenewCertificateRequest
  constructor: (@product, @years, @csr, @dcvType) ->
    @subjectAlternativeNames = []
    @dcv = []
    @company = ''
    @department = ''
    @address = ''
    @zipcode = ''
    @city = ''
    @approverFirstName = ''
    @approverLastName = ''
    @approverEmail = ''
    @approverPhone = ''
    @kvk = ''
    @reference = ''

  toArray: () =>
    result = {
      product: @product,
      years: @years,
      csr: @csr,
      dcvType: @dcvType
    }

    result['subjectAlternativeNames'] = @subjectAlternativeNames.join(',') if @subjectAlternativeNames.length > 0
    result['dcv'] = JSON.stringify(@dcv) if @dcv.length > 0
    result['company'] = @company if @company != ''
    result['department'] = @department if @department != ''
    result['address'] = @address if @address != ''
    result['zipcode'] = @zipcode if @zipcode != ''
    result['city'] = @city if @city != ''
    result['approverFirstName'] = @approverFirstName if @approverFirstName != ''
    result['approverLastName'] = @approverLastName if @approverLastName != ''
    result['approverEmail'] = @approverEmail if @approverEmail != ''
    result['approverPhone'] = @approverPhone if @approverPhone != ''
    result['kvk'] = @kvk if @kvk != ''
    result['reference'] = @reference if @reference != ''

    result

module.exports =
  CreateCertificateRequest: CreateCertificateRequest
  ReissueCertificateRequest: ReissueCertificateRequest
  RenewCertificateRequest: RenewCertificateRequest